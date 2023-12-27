package ncu.im3069.demo.app;

import java.sql.*;
import org.json.*;
import ncu.im3069.demo.util.DBMgr;

public class ManagerHelper {

    private static ManagerHelper mh;
    private Connection conn = null;
    private PreparedStatement pres = null;

    private ManagerHelper() {
    }

    public static ManagerHelper getHelper() {
        if (mh == null)
            mh = new ManagerHelper();
        return mh;
    }

    public JSONObject create(String name, String email, String password) {
        String execute_sql = "";
        int row = 0;
        JSONObject response = new JSONObject();
        try {
            conn = DBMgr.getConnection();
            String sql = "INSERT INTO `manager` (`manager_name`, `manager_email`, `manager_password`) VALUES (?, ?, ?)";
            pres = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pres.setString(1, name);
            pres.setString(2, email);
            pres.setString(3, password);
            row = pres.executeUpdate();

            ResultSet rs = pres.getGeneratedKeys();
            int newId = 0;
            if (rs.next()) {
                newId = rs.getInt(1);
            }

            JSONObject newData = new JSONObject();
            newData.put("id", newId);
            newData.put("name", name);
            newData.put("email", email);
            newData.put("password", password);

            execute_sql = pres.toString();
            response.put("status", "200");
            response.put("message", "新增成功");
            response.put("row", row);
            response.put("data", newData);
        } catch (SQLException e) {
            e.printStackTrace();
            response.put("status", "500");
            response.put("message", "新增失敗：" + e.getMessage());
        } finally {
            DBMgr.close(pres, conn);
        }
        return response;
    }

    public JSONObject deleteById(int manager_id) {
        String execute_sql = "";
        int row = 0;
        JSONObject response = new JSONObject();
        try {
            conn = DBMgr.getConnection();
            String sql = "DELETE FROM `manager` WHERE `manager_id` = ? LIMIT 1";

            pres = conn.prepareStatement(sql);
            pres.setInt(1, manager_id);
            row = pres.executeUpdate();

            execute_sql = pres.toString();
            response.put("sql", execute_sql);
            response.put("row", row);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBMgr.close(pres, conn);
        }

        return response;
    }

    public JSONObject update(int id, String name, String email, String password) {
        String execute_sql = "";
        int row = 0;
        JSONObject response = new JSONObject();
        try {
            conn = DBMgr.getConnection();
            String sql = "UPDATE `manager` SET `manager_name` = ?, `manager_email` = ?, `manager_password` = ? WHERE `manager_id` = ?";

            pres = conn.prepareStatement(sql);
            pres.setString(1, name);
            pres.setString(2, email);
            pres.setString(3, password);
            pres.setInt(4, id);
            row = pres.executeUpdate();

            execute_sql = pres.toString();
            response.put("sql", execute_sql);
            response.put("row", row);

            // 添加成功消息
            if (row > 0) {
                response.put("message", "更新成功");
            } else {
                response.put("message", "更新失败");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.put("message", "数据库错误: " + e.getMessage());
        } finally {
            DBMgr.close(pres, conn);
        }

        return response;
    }
    
    public JSONObject getById(int manager_id) {
        JSONArray jsa = new JSONArray();
        String execute_sql = "";
        int row = 0;
        ResultSet rs = null;

        try {
            conn = DBMgr.getConnection();
            String sql = "SELECT * FROM `manager` WHERE `manager_id` = ?";

            pres = conn.prepareStatement(sql);
            pres.setInt(1, manager_id);
            rs = pres.executeQuery();
            execute_sql = pres.toString();

            while (rs.next()) {
                row += 1;

                int id = rs.getInt("manager_id");
                String name = rs.getString("manager_name");
                String email = rs.getString("manager_email");
                String password = rs.getString("manager_password");

                JSONObject jso = new JSONObject();
                jso.put("id", id);
                jso.put("name", name);
                jso.put("email", email);
                jso.put("password", password);

                jsa.put(jso);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBMgr.close(rs, pres, conn);
        }

        JSONObject response = new JSONObject();
        response.put("sql", execute_sql);
        response.put("row", row);
        response.put("data", jsa);

        return response;
    }

    public JSONObject getAll() {
        JSONArray jsa = new JSONArray();
        String execute_sql = "";
        int row = 0;
        ResultSet rs = null;

        try {
            conn = DBMgr.getConnection();
            String sql = "SELECT * FROM `manager`";

            pres = conn.prepareStatement(sql);
            rs = pres.executeQuery();
            execute_sql = pres.toString();

            while (rs.next()) {
                row += 1;

                int manager_id = rs.getInt("manager_id");
                String manager_name = rs.getString("manager_name");
                String manager_email = rs.getString("manager_email");
                String manager_password = rs.getString("manager_password");

                JSONObject jso = new JSONObject();
                jso.put("id", manager_id);
                jso.put("name", manager_name);
                jso.put("email", manager_email);
                jso.put("password", manager_password);

                jsa.put(jso);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBMgr.close(rs, pres, conn);
        }

        JSONObject response = new JSONObject();
        response.put("sql", execute_sql);
        response.put("row", row);
        response.put("data", jsa);

        return response;
    }

    public boolean validateLogin(String email, String password) {
        ResultSet rs = null;
        boolean isValidUser = false;
        try {
            conn = DBMgr.getConnection();
            String sql = "SELECT * FROM `manager` WHERE `manager_email` = ? AND `manager_password` = ?";

            pres = conn.prepareStatement(sql);
            pres.setString(1, email);
            pres.setString(2, password);
            rs = pres.executeQuery();

            if (rs.next()) {
                isValidUser = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBMgr.close(rs, pres, conn);
        }

        return isValidUser;
    }
}
