package juanan.WEBINF.classes.demo.app;

import java.sql.*;
import org.json.*;
import juanan.WEBINF.classes.demo.util.DBMgr;

public class ProductHelper {
    
    private static ProductHelper ph;
    private Connection conn = null;
    private CallableStatement cstmt = null;

    private ProductHelper() {}

    public static ProductHelper getHelper() {
        if(ph == null) ph = new ProductHelper();
        return ph;
    }

    // 添加產品
    public JSONObject addProduct(String productName, int supplierId, int warehouseId, int quantity, int price) {
        JSONObject result = new JSONObject();
        try {
            conn = DBMgr.getConnection();
            cstmt = conn.prepareCall("{CALL sp_addproduct(?, ?, ?, ?, ?)}");
            cstmt.setString(1, productName);
            cstmt.setInt(2, supplierId);
            cstmt.setInt(3, warehouseId);
            cstmt.setInt(4, quantity);
            cstmt.setInt(5, price);

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

    // 刪除產品
    public JSONObject deleteProduct(int productId) {
        JSONObject result = new JSONObject();
        try {
            conn = DBMgr.getConnection();
            cstmt = conn.prepareCall("{CALL sp_deleteproduct(?)}");
            cstmt.setInt(1, productId);

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

    // 轉移產品
    public JSONObject transferProduct(String productName, int sourceWarehouseId, int destWarehouseId, int quantity) {
        JSONObject result = new JSONObject();
        try {
            conn = DBMgr.getConnection();
            cstmt = conn.prepareCall("{CALL sp_transfer_product(?, ?, ?, ?)}");
            cstmt.setString(1, productName);
            cstmt.setInt(2, sourceWarehouseId);
            cstmt.setInt(3, destWarehouseId);
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

    // 更新產品
    public JSONObject updateProduct(int productId, String productName, int supplierId, int warehouseId, int quantity, int price) {
        JSONObject result = new JSONObject();
        try {
            conn = DBMgr.getConnection();
            cstmt = conn.prepareCall("{CALL sp_updateproduct(?, ?, ?, ?, ?, ?)}");
            cstmt.setInt(1, productId);
            cstmt.setString(2, productName);
            cstmt.setInt(3, supplierId);
            cstmt.setInt(4, warehouseId);
            cstmt.setInt(5, quantity);
            cstmt.setInt(6, price);

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

    // 獲取所有產品
    public JSONObject getAllProducts() {
        JSONArray products = new JSONArray();
        PreparedStatement pres = null;
        try {
            conn = DBMgr.getConnection();
            String sql = "SELECT * FROM product";
            pres = conn.prepareStatement(sql);
    
            ResultSet rs = pres.executeQuery();
            while (rs.next()) {
                JSONObject product = new JSONObject();
                product.put("product_id", rs.getInt("product_id"));
                product.put("product_name", rs.getString("product_name"));
                product.put("supplier_id", rs.getInt("supplier_id"));
                product.put("product_location", rs.getString("product_location"));
                product.put("product_quantity", rs.getInt("product_quantity"));
                product.put("product_price", rs.getInt("product_price"));
                products.put(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBMgr.close(pres, conn);
        }
    
        JSONObject result = new JSONObject();
        result.put("status", "200");
        result.put("message", "所有產品資料取得成功");
        result.put("response", products);
        return result;
    }
    
}
