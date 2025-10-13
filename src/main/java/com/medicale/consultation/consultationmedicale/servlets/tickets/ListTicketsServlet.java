package com.medicale.consultation.consultationmedicale.servlets.tickets;

import com.medicale.consultation.consultationmedicale.config.JPAUtils;
import com.medicale.consultation.consultationmedicale.models.Ticket;
import com.medicale.consultation.consultationmedicale.services.TicketService;
import com.medicale.consultation.consultationmedicale.servlets.BaseServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/nurse/tickets")
public class ListTicketsServlet extends BaseServlet {
    private TicketService  ticketService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.ticketService = new TicketService(JPAUtils.getEntityManager());
    }

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Ticket> tickets = ticketService.findAllByDateDesc();

        req.setAttribute("tickets", tickets);
        render(req, resp, "nurse/tickets.jsp");
    }
}
