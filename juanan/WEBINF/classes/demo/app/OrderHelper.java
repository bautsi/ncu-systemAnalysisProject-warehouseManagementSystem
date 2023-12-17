package juanan.WEBINF.classes.demo.app;

import java.sql.*;
import org.json.*;

import juanan.WEBINF.classes.demo.util.DBMgr;

public class OrderHelper {
    
    private static OrderHelper oh;
    
    private OrderHelper() {}

    public static OrderHelper getHelper() {
        if(oh == null) oh = new OrderHelper();
        return oh;
    }
    
    public JSONObject addOrder(int managerId, String productName, int quantity) {
        JSONObject result = new JSONObject();
        Connection conn = null;
        CallableStatement cstmt = null;
        try {
            conn = DBMgr.getConnection();
            cstmt = conn.prepareCall("{CALL sp_add_order(?, ?, ?)}");

            cstmt.setInt(1, managerId);
            cstmt.setString(2, productName);
            cstmt.setInt(3, quantity);

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
}
