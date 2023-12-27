package juanan.WEBINF.classes.demo.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import org.json.*;

import juanan.WEBINF.classes.demo.app.OrderHelper;
import juanan.WEBINF.classes.tools.JsonReader;
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
            String productLocation = jso.getString("product_location"); // 新增的参数
            int quantity = jso.getInt("quantity");

            // 确保传递所有必要的参数给 addOrder 方法
            JSONObject result = oh.addOrder(managerId, productName, productLocation, quantity);
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
        } else if ("comparePackedOrders".equals(action)) {
            JSONObject result = oh.comparePackedOrders();
            resp.put("status", "200");
            resp.put("message", "最大銷售總量對比成功");
            resp.put("response", result);
        } else if ("compareMaxSalesOrder".equals(action)) {
            JSONObject result = oh.compareMaxSalesOrder();
            resp.put("status", "200");
            resp.put("message", "最大銷售總額對比成功");
            resp.put("response", result);
        } else if ("updateOrder".equals(action)) {
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
