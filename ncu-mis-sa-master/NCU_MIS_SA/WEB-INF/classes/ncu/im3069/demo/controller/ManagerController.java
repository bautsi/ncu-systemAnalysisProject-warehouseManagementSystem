package ncu.im3069.demo.controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import org.json.*;
import ncu.im3069.demo.app.ManagerHelper;
import ncu.im3069.tools.JsonReader;
import javax.servlet.annotation.WebServlet;

@WebServlet("/api/manager.do")
public class ManagerController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ManagerHelper mh = ManagerHelper.getHelper();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JsonReader jsr = new JsonReader(request);
        JSONObject jso = jsr.getObject();

        String action = jso.optString("action", "");
        switch (action) {
            case "login":
                handleLogin(jso, jsr, response);
                break;
            case "add":
                handleCreate(jso, jsr, response);
                break;
            case "update":
                handleUpdate(jso, jsr, response);
                break;
            // 其他 POST 操作...
        }
    }

    private void handleLogin(JSONObject jso, JsonReader jsr, HttpServletResponse response)
            throws IOException {
        String email = jso.getString("email");
        String password = jso.getString("password");

        boolean isValidUser = mh.validateLogin(email, password);
        JSONObject resp = new JSONObject();
        if (isValidUser) {
            resp.put("status", "200");
            resp.put("message", "登入成功");
        } else {
            resp.put("status", "400");
            resp.put("message", "登入失敗：管理員不存在或密碼錯誤");
        }

        jsr.response(resp, response);
    }

    private void handleCreate(JSONObject jso, JsonReader jsr, HttpServletResponse response)
            throws IOException {
        String name = jso.getString("manager_name");
        String email = jso.getString("manager_username");
        String password = jso.getString("manager_password");

        JSONObject data = mh.create(name, email, password);
        jsr.response(data, response);
    }

    private void handleUpdate(JSONObject jso, JsonReader jsr, HttpServletResponse response) throws IOException {
        int id = jso.getInt("manager_id");
        String name = jso.getString("manager_name");
        String email = jso.getString("manager_username");
        String password = jso.getString("manager_password");

        JSONObject data = mh.update(id, name, email, password);
        jsr.response(data, response); // 这里已经包含了成功或失败的消息
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JsonReader jsr = new JsonReader(request);
        String id = jsr.getParameter("id");

        JSONObject resp;
        if (id.isEmpty()) {
            JSONObject query = mh.getAll();
            resp = new JSONObject();
            resp.put("status", "200");
            resp.put("message", "所有管理員資料取得成功");
            resp.put("response", query);
        } else {
            JSONObject query = mh.getById(Integer.parseInt(id));
            resp = new JSONObject();
            resp.put("status", "200");
            resp.put("message", "管理員資料取得成功");
            resp.put("response", query);
        }

        jsr.response(resp, response);
    }

    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JsonReader jsr = new JsonReader(request);
        int id = Integer.parseInt(request.getParameter("manager_id")); // 确保能正确获取 manager_id

        JSONObject query = mh.deleteById(id);
        JSONObject resp = new JSONObject();
        resp.put("status", "200");
        resp.put("message", "管理員移除成功！");
        resp.put("response", query);

        jsr.response(resp, response);
    }

    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JsonReader jsr = new JsonReader(request);
        JSONObject jso = jsr.getObject();

        int id = jso.getInt("id");
        String name = jso.getString("name");
        String email = jso.getString("email");
        String password = jso.getString("password");

        JSONObject data = mh.update(id, name, email, password);

        JSONObject resp = new JSONObject();
        resp.put("status", "200");
        resp.put("message", "成功! 更新管理員資料...");
        resp.put("response", data);

        jsr.response(resp, response);
    }
}