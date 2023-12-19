package juanan.WEBINF.classes.demo.controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import org.json.*;
import juanan.WEBINF.classes.demo.app.Manager;
import juanan.WEBINF.classes.demo.app.ManagerHelper;
import juanan.WEBINF.classes.tools.JsonReader;
import javax.servlet.annotation.WebServlet;

// TODO: Auto-generated Javadoc
/**
 * <p>
 * The Class ManagerController<br>
 * ManagerController類別（class）主要用於處理Manager相關之Http請求（Request），繼承HttpServlet
 * </p>
 * 
 * @author IPLab
 * @version 1.0.0
 * @since 1.0.0
 */
@WebServlet("/api/manager.do")
public class ManagerController extends HttpServlet {
    
    /** The Constant serialVersionUID. */
    private static final long serialVersionUID = 1L;
    
    /** mh，ManagerHelper之物件與Manager相關之資料庫方法（Sigleton） */
    private ManagerHelper mh =  ManagerHelper.getHelper();
    
    /**
     * 處理Http Method請求POST方法（新增資料）
     *
     * @param request Servlet請求之HttpServletRequest之Request物件（前端到後端）
     * @param response Servlet回傳之HttpServletResponse之Response物件（後端到前端）
     * @throws ServletException the servlet exception
     * @throws IOException Signals that an I/O exception has occurred.
     */
    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        /** 通过 JsonReader 类将 Request 的 JSON 格式数据解析并取回 */
        JsonReader jsr = new JsonReader(request);
        JSONObject jso = jsr.getObject();
        
        /** 根据操作类型进行不同的处理 */
        String action = jso.optString("action", "");
        if ("login".equals(action)) {
            // 处理登录操作
            handleLogin(jso, jsr, response);
        } else {
            // 处理创建（新增）操作
            handleCreate(jso, jsr, response);
        }
    }

    private void handleLogin(JSONObject jso, JsonReader jsr, HttpServletResponse response) 
        throws IOException {
        // 从 JSON 对象中取出 email 和 password
        String email = jso.getString("email");
        String password = jso.getString("password");

        // 进行登录验证
        boolean isValidUser = mh.validateLogin(email, password);

        // 构建响应
        JSONObject resp = new JSONObject();
        if (isValidUser) {
            resp.put("status", "200");
            resp.put("message", "登录成功");
        } else {
            resp.put("status", "400");
            resp.put("message", "登录失败：用户不存在或密码错误");
        }

        // 通过 JsonReader 对象回传到前端
        jsr.response(resp, response);
    }

    private void handleCreate(JSONObject jso, JsonReader jsr, HttpServletResponse response) 
        throws IOException {
        // 解析 JSON 对象中的字段
        String name = jso.getString("name");
        String email = jso.getString("email");
        String password = jso.getString("password");
        
        // 创建新的管理员对象
        Manager m = new Manager(name, email, password);
        
        // 后端检查是否有字段为空
        if (name.isEmpty() || email.isEmpty() || password.isEmpty()) {
            String resp = "{\"status\": '400', \"message\": '欄位不能有空值', 'response': ''}";
            jsr.response(resp, response);
        }
        // 检查该管理员电子邮件信箱是否有重复
        else if (!mh.checkDuplicate(m)) {
            JSONObject data = mh.create(m);
            
            JSONObject resp = new JSONObject();
            resp.put("status", "200");
            resp.put("message", "成功! 新增管理員資料...");
            resp.put("response", data);
            
            jsr.response(resp, response);
        }
        else {
            String resp = "{\"status\": '400', \"message\": '新增帳號失敗，此E-Mail帳號重複！', 'response': ''}";
            jsr.response(resp, response);
        }
    }

    /**
     * 處理Http Method請求GET方法（取得資料）
     *
     * @param request Servlet請求之HttpServletRequest之Request物件（前端到後端）
     * @param response Servlet回傳之HttpServletResponse之Response物件（後端到前端）
     * @throws ServletException the servlet exception
     * @throws IOException Signals that an I/O exception has occurred.
     */
    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        /** 透過JsonReader類別將Request之JSON格式資料解析並取回 */
        JsonReader jsr = new JsonReader(request);
        /** 若直接透過前端AJAX之data以key=value之字串方式進行傳遞參數，可以直接由此方法取回資料 */
        String id = jsr.getParameter("id");
        
        /** 判斷該字串是否存在，若存在代表要取回個別管理員之資料，否則代表要取回全部資料庫內管理員之資料 */
        if (id.isEmpty()) {
            /** 透過ManagerHelper物件之getAll()方法取回所有管理員之資料，回傳之資料為JSONObject物件 */
            JSONObject query = mh.getAll();
            
            /** 新建一個JSONObject用於將回傳之資料進行封裝 */
            JSONObject resp = new JSONObject();
            resp.put("status", "200");
            resp.put("message", "所有管理員資料取得成功");
            resp.put("response", query);
    
            /** 透過JsonReader物件回傳到前端（以JSONObject方式） */
            jsr.response(resp, response);
        }
        else {
            /** 透過ManagerHelper物件的getByID()方法自資料庫取回該名管理員之資料，回傳之資料為JSONObject物件 */
            JSONObject query = mh.getByID(id);
            
            /** 新建一個JSONObject用於將回傳之資料進行封裝 */
            JSONObject resp = new JSONObject();
            resp.put("status", "200");
            resp.put("message", "管理員資料取得成功");
            resp.put("response", query);
    
            /** 透過JsonReader物件回傳到前端（以JSONObject方式） */
            jsr.response(resp, response);
        }
    }

    /**
     * 處理Http Method請求DELETE方法（刪除）
     *
     * @param request Servlet請求之HttpServletRequest之Request物件（前端到後端）
     * @param response Servlet回傳之HttpServletResponse之Response物件（後端到前端）
     * @throws ServletException the servlet exception
     * @throws IOException Signals that an I/O exception has occurred.
     */
    public void doDelete(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        /** 透過JsonReader類別將Request之JSON格式資料解析並取回 */
        JsonReader jsr = new JsonReader(request);
        JSONObject jso = jsr.getObject();
        
        /** 取出經解析到JSONObject之Request參數 */
        int id = jso.getInt("id");
        
        /** 透過ManagerHelper物件的deleteByID()方法至資料庫刪除該名管理員，回傳之資料為JSONObject物件 */
        JSONObject query = mh.deleteByID(id);
        
        /** 新建一個JSONObject用於將回傳之資料進行封裝 */
        JSONObject resp = new JSONObject();
        resp.put("status", "200");
        resp.put("message", "管理員移除成功！");
        resp.put("response", query);

        /** 透過JsonReader物件回傳到前端（以JSONObject方式） */
        jsr.response(resp, response);
    }

    /**
     * 處理Http Method請求PUT方法（更新）
     *
     * @param request Servlet請求之HttpServletRequest之Request物件（前端到後端）
     * @param response Servlet回傳之HttpServletResponse之Response物件（後端到前端）
     * @throws ServletException the servlet exception
     * @throws IOException Signals that an I/O exception has occurred.
     */
    public void doPut(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        /** 透過JsonReader類別將Request之JSON格式資料解析並取回 */
        JsonReader jsr = new JsonReader(request);
        JSONObject jso = jsr.getObject();
        
        /** 取出經解析到JSONObject之Request參數 */
        int id = jso.getInt("id");
        String name = jso.getString("name");
        String email = jso.getString("email");
        String password = jso.getString("password");

        /** 透過傳入之參數，新建一個以這些參數之管理員Manager物件 */
        Manager m = new Manager(id, name, email, password);
        
        /** 透過Manager物件的update()方法至資料庫更新該名管理員資料，回傳之資料為JSONObject物件 */
        JSONObject data = m.update();
        
        /** 新建一個JSONObject用於將回傳之資料進行封裝 */
        JSONObject resp = new JSONObject();
        resp.put("status", "200");
        resp.put("message", "成功! 更新管理員資料...");
        resp.put("response", data);
        
        /** 透過JsonReader物件回傳到前端（以JSONObject方式） */
        jsr.response(resp, response);
    }
}