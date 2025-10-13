package com.medicale.consultation.consultationmedicale.repositories;

import com.medicale.consultation.consultationmedicale.models.Ticket;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class TicketRepository {
    private EntityManager em;

    public TicketRepository(EntityManager em) {
        this.em = em;
    }

    public Ticket findById(int id) {
        return em.find(Ticket.class, id);
    }

    public void save(Ticket ticket) {
        em.getTransaction().begin();
        em.persist(ticket);
        em.getTransaction().commit();
    }

    public List<Ticket> findAll() {
        TypedQuery<Ticket> query = em.createQuery("SELECT t FROM Ticket t", Ticket.class);
        return query.getResultList();
    }

    public List<Ticket> findAllByDateDesc() {
        return em.createQuery("SELECT t FROM Ticket t WHERE FUNCTION('DATE', t.createdAt) = CURRENT_DATE ORDER BY t.createdAt DESC", Ticket.class)
                .getResultList();
    }
}
