package com.medicale.consultation.consultationmedicale.servlets.auth;

import com.medicale.consultation.consultationmedicale.models.person.Person;
import com.medicale.consultation.consultationmedicale.services.user.UserService;
import com.medicale.consultation.consultationmedicale.servlets.BaseServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "loginServlet", value = "/login")
public class LoginServlet extends BaseServlet {
    private UserService userService;

    @Override
    public void init() throws ServletException {
        super.init();
        userService = new UserService(getEntityManager());
    }

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);

        if (session != null && session.getAttribute("user") != null) {
            // User already logged in → redirect them to dashboard
            resp.sendRedirect(req.getContextPath() + "/dashboard");
            return;
        }

        render(req, resp, "login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        handleLogin(req, resp);
    }

    // Handles user login and redirects based on role.
    private void handleLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        Person user = userService.authenticate(username, password);

        if(user != null){
            // credential are valid -> store userID and userRole
            req.getSession().setAttribute("userId", user.getId());
            req.getSession().setAttribute("userRole", user.getRole().name());
            // store full user object
            req.getSession().setAttribute("user", user);

            System.out.println("✅ User authenticated: " + user.getUsername() + " | Role: " + user.getRole());
            resp.sendRedirect(req.getContextPath() + "/dashboard");
            System.out.println("➡ Redirecting to: " + req.getContextPath() + "/dashboard");
        } else {
            req.setAttribute("error", "Invalid username or password");
            render(req, resp, "/login.jsp");
        }
    }
}
