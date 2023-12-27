package juanan.WEBINF.classes.demo.app;

import java.sql.*;
import org.json.*;
import juanan.WEBINF.classes.demo.util.DBMgr;

public class SupplierHelper {

    private static SupplierHelper sh;
    private Connection conn = null;
    private CallableStatement cstmt = null;

    private SupplierHelper() {
    }

    public static SupplierHelper getHelper() {
        if (sh == null)
            sh = new SupplierHelper();
        return sh;
    }

    // 新增供應商
    public JSONObject addSupplier(String supplierName) {
        JSONObject result = new JSONObject();
        try {
            conn = DBMgr.getConnection();
            cstmt = conn.prepareCall("{CALL sp_addsupplier(?)}");
            cstmt.setString(1, supplierName);

            ResultSet rs = cstmt.executeQuery();
            if (rs.next()) {
                result.put("new_supplier_id", rs.getInt("new_supplier_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            result.put("error", e.getMessage());
        } finally {
            DBMgr.close(cstmt, conn);
        }
        return result;
    }

    // 刪除供應商
    public JSONObject deleteSupplier(int supplierId) {
        JSONObject result = new JSONObject();
        try {
            conn = DBMgr.getConnection();
            cstmt = conn.prepareCall("{CALL sp_deletesupplier(?)}");
            cstmt.setInt(1, supplierId);

            int affectedRows = cstmt.executeUpdate(); // 执行删除操作，返回受影响的行数
            if (affectedRows > 0) {
                result.put("message", "Supplier deleted successfully.");
            } else {
                result.put("message", "No supplier was deleted.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            result.put("error", e.getMessage());
        } finally {
            DBMgr.close(cstmt, conn);
        }
        return result;
    }

    // 更新供應商
    public JSONObject updateSupplier(int supplierId, String supplierName) {
        JSONObject result = new JSONObject();
        try {
            conn = DBMgr.getConnection();
            cstmt = conn.prepareCall("{CALL sp_updatesupplier(?, ?)}");
            cstmt.setInt(1, supplierId);
            cstmt.setString(2, supplierName);

            int affectedRows = cstmt.executeUpdate(); // 使用 executeUpdate 获取受影响的行数
            if (affectedRows > 0) {
                result.put("message", "Supplier updated successfully.");
            } else {
                result.put("message", "No supplier was updated."); // 如果没有行受影响，返回相应消息
            }
        } catch (SQLException e) {
            e.printStackTrace();
            result.put("error", e.getMessage());
        } finally {
            DBMgr.close(cstmt, conn);
        }
        return result;
    }

    // 獲取所有供應商
    public JSONObject getAllSuppliers() {
        JSONArray suppliers = new JSONArray();
        try {
            conn = DBMgr.getConnection();
            String sql = "SELECT * FROM supplier";
            PreparedStatement pres = conn.prepareStatement(sql);

            ResultSet rs = pres.executeQuery();
            while (rs.next()) {
                JSONObject supplier = new JSONObject();
                supplier.put("supplier_id", rs.getInt("supplier_id"));
                supplier.put("supplier_name", rs.getString("supplier_name"));
                suppliers.put(supplier);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBMgr.close(cstmt, conn);
        }

        JSONObject result = new JSONObject();
        result.put("status", "200");
        result.put("message", "所有供應商資料取得成功");
        result.put("response", suppliers);
        return result;
    }
}
