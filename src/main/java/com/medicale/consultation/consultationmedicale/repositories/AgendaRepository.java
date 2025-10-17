package com.medicale.consultation.consultationmedicale.repositories;

import com.medicale.consultation.consultationmedicale.models.Agenda;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.util.List;

public class AgendaRepository {
    private EntityManager em;

    public AgendaRepository(EntityManager em) {
        this.em = em;
    }

    public void saveAll(List<Agenda> agendas) {
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            for (Agenda agenda : agendas) {
                em.persist(agenda);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        }
    }

    public boolean existsConflict(int specialistId, java.time.LocalDate date, java.time.LocalTime startTime, java.time.LocalTime endTime) {
        Long count = em.createQuery(
                        "SELECT COUNT(a) FROM Agenda a WHERE a.specialist.id = :specialistId AND a.date = :date AND a.startTime = :startTime AND a.endTime = :endTime",
                        Long.class)
                .setParameter("specialistId", specialistId)
                .setParameter("date", date)
                .setParameter("startTime", startTime)
                .setParameter("endTime", endTime)
                .getSingleResult();

        return count > 0;
    }

    public void delete(Agenda agenda) {
        em.getTransaction().begin();
        em.remove(agenda);
        em.getTransaction().commit();
    }

    public List<Agenda> getAll() {
        return em.createQuery("SELECT a FROM Agenda a", Agenda.class).getResultList();
    }

    public Agenda getById(int id) {
        return em.find(Agenda.class, id);
    }
}
