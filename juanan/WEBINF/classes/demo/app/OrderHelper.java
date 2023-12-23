package juanan.WEBINF.classes.demo.app;

import java.sql.*;
import org.json.*;

import juanan.WEBINF.classes.demo.util.DBMgr;

public class OrderHelper {

    private static OrderHelper oh;

    private OrderHelper() {
    }

    public static OrderHelper getHelper() {
        if (oh == null)
            oh = new OrderHelper();
        return oh;
    }

    public JSONObject addOrder(int managerId, String productName, String productLocation, int quantity) {
        JSONObject result = new JSONObject();
        Connection conn = null;
        CallableStatement cstmt = null;
        try {
            conn = DBMgr.getConnection();
            // 確保調用的存儲過程名稱與您提供的存儲過程相匹配
            cstmt = conn.prepareCall("{CALL sp_add_order1(?, ?, ?, ?)}");

            cstmt.setInt(1, managerId);
            cstmt.setString(2, productName);
            cstmt.setString(3, productLocation);
            cstmt.setInt(4, quantity);

            ResultSet rs = cstmt.executeQuery();
            if (rs.next()) {
                result.put("result", rs.getString("result"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            result.put("error", e.getMessage());
        } finally {
            DBMgr.close(cstmt, conn);
        }
        return result;
    }

    public JSONObject packOrder(int orderId) {
        JSONObject result = new JSONObject();
        Connection conn = null;
        CallableStatement cstmt = null;
        try {
            conn = DBMgr.getConnection();
            cstmt = conn.prepareCall("{CALL sp_pack_order(?)}");

            cstmt.setInt(1, orderId);

            boolean hasResultSet = cstmt.execute();
            if (hasResultSet) {
                ResultSet rs = cstmt.getResultSet();
                if (rs.next()) {
                    result.put("result", rs.getString("result"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            result.put("error", e.getMessage());
        } finally {
            DBMgr.close(cstmt, conn);
        }
        return result;
    }

    public JSONArray viewOrders() {
        JSONArray orders = new JSONArray();
        Connection conn = null;
        CallableStatement cstmt = null;
        try {
            conn = DBMgr.getConnection();
            cstmt = conn.prepareCall("{CALL sp_view_orders()}");

            ResultSet rs = cstmt.executeQuery();
            while (rs.next()) {
                JSONObject order = new JSONObject();
                order.put("order_id", rs.getInt("order_id"));
                order.put("manager_id", rs.getInt("manager_id"));
                order.put("product_name", rs.getString("orders_product_name"));
                order.put("product_price", rs.getDouble("orders_product_price"));
                order.put("product_quantity", rs.getInt("orders_product_quantity"));
                order.put("packed_time", rs.getTimestamp("orders_packed_time"));
                order.put("statement", rs.getString("orders_statement"));
                orders.put(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBMgr.close(cstmt, conn);
        }
        return orders;
    }

    public JSONObject comparePackedOrders() {
        JSONObject result = new JSONObject();
        Connection conn = null;
        CallableStatement cstmt = null;
        try {
            conn = DBMgr.getConnection();
            cstmt = conn.prepareCall("{CALL sp_compare_packed_orders()}");

            ResultSet rs = cstmt.executeQuery();
            if (rs.next()) {
                result.put("result", rs.getString("result"));
                result.put("max_sales_total", rs.getInt("max_sales_total"));
                result.put("product_result", rs.getString("product_result"));
                result.put("product_name_result", rs.getString("product_name_result"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            result.put("error", e.getMessage());
        } finally {
            DBMgr.close(cstmt, conn);
        }
        return result;
    }

    public JSONObject deleteOrder(int orderId) {
        JSONObject result = new JSONObject();
        Connection conn = null;
        CallableStatement cstmt = null;
        try {
            conn = DBMgr.getConnection();
            cstmt = conn.prepareCall("{CALL sp_delete_order(?)}");

            cstmt.setInt(1, orderId);

            ResultSet rs = cstmt.executeQuery();
            if (rs.next()) {
                result.put("result", rs.getString("result"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            result.put("error", e.getMessage());
        } finally {
            DBMgr.close(cstmt, conn);
        }
        return result;
    }

    public JSONObject compareMaxSalesOrder() {
        JSONObject result = new JSONObject();
        Connection conn = null;
        CallableStatement cstmt = null;
        try {
            conn = DBMgr.getConnection();
            cstmt = conn.prepareCall("{CALL sp_compare_max_sales_order()}");

            ResultSet rs = cstmt.executeQuery();
            if (rs.next()) {
                result.put("result", rs.getString("result"));
                result.put("max_sales_total", rs.getBigDecimal("max_sales_total"));
                result.put("product_result", rs.getString("product_result"));
                result.put("orders_product_name_result", rs.getString("orders_product_name_result"));
                result.put("total_price_result", rs.getString("total_price_result"));
                result.put("total_price_value", rs.getBigDecimal("total_price_result"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            result.put("error", e.getMessage());
        } finally {
            DBMgr.close(cstmt, conn);
        }
        return result;
    }

    public JSONObject updateOrder(int orderId, int newQuantity) {
        JSONObject result = new JSONObject();
        Connection conn = null;
        CallableStatement cstmt = null;
        try {
            conn = DBMgr.getConnection();
            cstmt = conn.prepareCall("{CALL sp_update_orders(?, ?)}");

            cstmt.setInt(1, orderId);
            cstmt.setInt(2, newQuantity);

            ResultSet rs = cstmt.executeQuery();
            if (rs.next()) {
                result.put("result", rs.getString("result"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            result.put("error", e.getMessage());
        } finally {
            DBMgr.close(cstmt, conn);
        }
        return result;
    }

    public JSONObject generateSalesReport() {
        JSONObject result = new JSONObject();
        JSONArray salesReport = new JSONArray();
        Connection conn = null;
        CallableStatement cstmt = null;
        try {
            conn = DBMgr.getConnection();
            cstmt = conn.prepareCall("{CALL sp_generate_sales_report()}");

            ResultSet rs = cstmt.executeQuery();
            while (rs.next()) {
                JSONObject reportItem = new JSONObject();
                reportItem.put("product_name", rs.getString("product_name"));
                reportItem.put("total_quantity", rs.getInt("total_quantity"));
                reportItem.put("unit_price", rs.getDouble("unit_price"));
                reportItem.put("total_sales", rs.getDouble("total_sales"));
                salesReport.put(reportItem);
            }
            result.put("status", "200");
            result.put("message", "Sales report generated successfully");
            result.put("response", salesReport);
        } catch (SQLException e) {
            e.printStackTrace();
            result.put("status", "500");
            result.put("error", e.getMessage());
        } finally {
            DBMgr.close(cstmt, conn);
        }
        return result;
    }

}
