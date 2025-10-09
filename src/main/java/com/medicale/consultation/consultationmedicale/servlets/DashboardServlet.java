package com.medicale.consultation.consultationmedicale.servlets;

import com.medicale.consultation.consultationmedicale.enums.Role;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "dashboardServlet", value = "/dashboard")
public class DashboardServlet extends BaseServlet{

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String role = session.getAttribute("userRole").toString();

        switch (role) {
            case "NURSE" -> req.getRequestDispatcher("/WEB-INF/views/nurse/dashboard.jsp").forward(req, resp);
            case "GENERALIST" -> req.getRequestDispatcher("/WEB-INF/views/generalist/dashboard.jsp").forward(req, resp);
            case "SPECIALIST" -> req.getRequestDispatcher("/WEB-INF/views/specialist/dashboard.jsp").forward(req, resp);
            default -> resp.sendError(HttpServletResponse.SC_FORBIDDEN);
        }
    }
}
