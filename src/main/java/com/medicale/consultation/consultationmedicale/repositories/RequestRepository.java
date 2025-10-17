package com.medicale.consultation.consultationmedicale.repositories;

import com.medicale.consultation.consultationmedicale.enums.RequestStatus;
import com.medicale.consultation.consultationmedicale.models.consultation.Request;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.util.List;

public class RequestRepository {
    private EntityManager em;

    public RequestRepository(EntityManager em) {
        this.em = em;
    }

    public void save(Request request) {
        em.getTransaction().begin();
        em.persist(request);
        em.getTransaction().commit();
    }

    public Request findById(int id) {
        return em.find(Request.class, id);
    }

    // Récupérer toutes les demandes d'un généraliste
    public List<Request> findByGeneralistId(int generalistId) {
        try {
            String jpql = "SELECT r FROM Request r " +
                    "JOIN r.consultation c " +
                    "WHERE c.generalist.id = :generalistId " +
                    "ORDER BY r.createdAt DESC";

            return em.createQuery(jpql, Request.class)
                    .setParameter("generalistId", generalistId)
                    .getResultList();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la récupération des demandes: " + e.getMessage(), e);
        }
    }

    // Récupérer les demandes par statut
    public List<Request> findByStatus(RequestStatus status) {
        try {
            String jpql = "SELECT r FROM Request r WHERE r.requestStatus = :status ORDER BY r.createdAt DESC";
            return em.createQuery(jpql, Request.class)
                    .setParameter("status", status)
                    .getResultList();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la récupération des demandes par statut: " + e.getMessage(), e);
        }
    }

    public void delete(int id) {
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            Request request = em.find(Request.class, id);
            if (request != null) {
                em.remove(request);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw new RuntimeException("Erreur lors de la suppression de la demande: " + e.getMessage(), e);
        }
    }

    // Mettre à jour une demande
    public void update(Request request) {
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.merge(request);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw new RuntimeException("Erreur lors de la mise à jour de la demande: " + e.getMessage(), e);
        }
    }
}
