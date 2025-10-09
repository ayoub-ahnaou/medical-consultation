package com.medicale.consultation.consultationmedicale.servlets;

import com.medicale.consultation.consultationmedicale.config.JPAUtils;
import jakarta.persistence.EntityManager;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.logging.Logger;

public abstract class BaseServlet extends HttpServlet {
    protected Logger logger = Logger.getLogger(this.getClass().getName());

    // render to a Java Server Page
    protected void render(HttpServletRequest req, HttpServletResponse resp, String jspPath) throws ServletException, IOException {
        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/" + jspPath);
        dispatcher.forward(req, resp);
    }

    protected EntityManager getEntityManager() {
        return JPAUtils.getEntityManager();
    }

    // redirect to another servlet or route
    protected void redirect(HttpServletResponse resp, String path) throws IOException {
        resp.sendRedirect(path);
    }

    // get current session without creating new one if it don't exist
    protected HttpSession getSession(HttpServletRequest req) {
        return req.getSession(false);
    }

    // Check if user is authenticated
    protected boolean isAuthenticated(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        return session != null && session.getAttribute("user") != null;
    }

    // get authenticated user
    protected Object getUser(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        return (session != null) ? session.getAttribute("user") : null;
    }

    // handle error by logging them
    protected void handleError(HttpServletResponse resp, Exception e)
            throws IOException {
        logger.severe("Error: " + e.getMessage());
        resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Something went wrong.");
    }

    // main middleware method
    protected boolean before(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        // prevent access if not logged in
        if (!isAuthenticated(req)) {
            redirect(resp, "/login.jsp");
            return false;
        }
        return true;
    }
}
