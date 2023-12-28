package ncu.im3069.demo.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import org.json.*;

import ncu.im3069.demo.app.OrderHelper;
import ncu.im3069.tools.JsonReader;
import javax.servlet.annotation.WebServlet;

@WebServlet("/api/order.do")
public class OrderController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private OrderHelper oh = OrderHelper.getHelper();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JsonReader jsr = new JsonReader(request);
        String action = jsr.getParameter("action");

        JSONObject resp = new JSONObject();
        if ("viewAll".equals(action)) {
            JSONArray orders = oh.viewOrders();
            resp.put("status", "200");
            resp.put("message", "所有訂單資料取得成功");
            resp.put("response", orders);
        }

        jsr.response(resp, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JsonReader jsr = new JsonReader(request);
        JSONObject jso = jsr.getObject();
        String action = jso.optString("action");

        JSONObject resp = new JSONObject();
        if ("addOrder".equals(action)) {
            int managerId = jso.getInt("manager_id");
            String productName = jso.getString("product_name");
            String productLocation = jso.optString("product_location");
            int productQuantity = jso.getInt("product_quantity"); 

            // 确保传递所有必要的参数给 addOrder 方法
            JSONObject result = oh.addOrder(managerId, productName, productLocation, productQuantity); // 这里使用的是合并后的参数
            resp.put("status", "200");
            resp.put("message", "訂單新增成功");
            resp.put("response", result);
        } else if ("packOrder".equals(action)) {
            int orderId = jso.getInt("order_id");

            JSONObject result = oh.packOrder(orderId);
            resp.put("status", "200");
            resp.put("message", "訂單打包成功");
            resp.put("response", result);
        } else if ("generateSalesReport".equals(action)) {
            JSONObject report = oh.generateSalesReport();
            resp.put("status", "200");
            resp.put("message", "销售报告生成成功");
            resp.put("response", report);
        } else if ("deleteOrder".equals(action)) {
            int orderId = jso.getInt("order_id");

            JSONObject result = oh.deleteOrder(orderId);
            resp.put("status", "200");
            resp.put("message", "訂單刪除成功");
            resp.put("response", result);
        }else if ("updateOrder".equals(action)) {
            int orderId = jso.getInt("order_id");
            int newQuantity = jso.getInt("new_quantity");

            JSONObject result = oh.updateOrder(orderId, newQuantity);
            resp.put("status", "200");
            resp.put("message", "訂單更新成功");
            resp.put("response", result);
        }

        jsr.response(resp, response);
    }
}
