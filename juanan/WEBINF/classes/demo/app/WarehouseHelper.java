package juanan.WEBINF.classes.demo.app;

import java.sql.*;
import org.json.*;
import juanan.WEBINF.classes.demo.util.DBMgr;

public class WarehouseHelper {

    private static WarehouseHelper wh;
    private Connection conn = null;
    private CallableStatement cstmt = null;

    private WarehouseHelper() {
    }

    public static WarehouseHelper getHelper() {
        if (wh == null)
            wh = new WarehouseHelper();
        return wh;
    }

    // 添加仓库
    public JSONObject addWarehouse(String warehouseName, String warehouseLocation, int managerId) {
        JSONObject result = new JSONObject();
        try {
            conn = DBMgr.getConnection();
            cstmt = conn.prepareCall("{CALL sp_addwarhouse(?, ?, ?)}");
            cstmt.setString(1, warehouseName);
            cstmt.setString(2, warehouseLocation);
            cstmt.setInt(3, managerId);

            int affectedRows = cstmt.executeUpdate(); // 使用 executeUpdate 而不是 executeQuery
            if (affectedRows > 0) {
                result.put("message", "Warehouse added successfully.");
            } else {
                result.put("message", "No warehouse was added.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            result.put("error", e.getMessage());
        } finally {
            DBMgr.close(cstmt, conn);
        }
        return result;
    }

    // 删除仓库
    public JSONObject deleteWarehouse(int warehouseId) {
        JSONObject result = new JSONObject();
        try {
            conn = DBMgr.getConnection();
            cstmt = conn.prepareCall("{CALL sp_deletewarhouse(?)}");
            cstmt.setInt(1, warehouseId);

            ResultSet rs = cstmt.executeQuery();
            if (rs.next()) {
                result.put("message", "Warehouse deleted successfully.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            result.put("error", e.getMessage());
        } finally {
            DBMgr.close(cstmt, conn);
        }
        return result;
    }

    // 更新仓库
    public JSONObject updateWarehouse(int warehouseId, String warehouseName, String warehouseLocation) {
        JSONObject result = new JSONObject();
        try {
            conn = DBMgr.getConnection();
            cstmt = conn.prepareCall("{CALL sp_updatewarhouse(?, ?, ?)}");
            cstmt.setInt(1, warehouseId);
            cstmt.setString(2, warehouseName);
            cstmt.setString(3, warehouseLocation);

            int affectedRows = cstmt.executeUpdate(); // 使用 executeUpdate 而不是 executeQuery
            if (affectedRows > 0) {
                result.put("message", "Warehouse updated successfully.");
            } else {
                result.put("message", "No warehouse was updated.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            result.put("error", e.getMessage());
        } finally {
            DBMgr.close(cstmt, conn);
        }
        return result;
    }

    // 获取所有仓库
    public JSONObject getAllWarehouses() {
        JSONArray warehouses = new JSONArray();
        PreparedStatement pres = null;
        try {
            conn = DBMgr.getConnection();
            String sql = "SELECT * FROM warhouse";
            pres = conn.prepareStatement(sql);

            ResultSet rs = pres.executeQuery();
            while (rs.next()) {
                JSONObject warehouse = new JSONObject();
                warehouse.put("warhouse_id", rs.getInt("warhouse_id"));
                warehouse.put("warhouse_name", rs.getString("warhouse_name"));
                warehouse.put("warhouse_location", rs.getString("warhouse_location"));
                warehouses.put(warehouse);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBMgr.close(pres, conn);
        }

        JSONObject result = new JSONObject();
        result.put("status", "200");
        result.put("message", "所有仓库数据获取成功");
        result.put("response", warehouses);
        return result;
    }
}
