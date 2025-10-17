package com.medicale.consultation.consultationmedicale.repositories;

import com.medicale.consultation.consultationmedicale.enums.ConsultationStatus;
import com.medicale.consultation.consultationmedicale.models.consultation.Consultation;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.util.List;

public class ConsultationRepository {
    private EntityManager em;

    public ConsultationRepository(EntityManager em) {
        this.em = em;
    }

    public Consultation getConsultationById(int id) {
        return em.find(Consultation.class, id);
    }

    public List<Consultation> findAll() {
        return em.createQuery("SELECT c FROM Consultation c", Consultation.class).getResultList();
    }

    // Récupérer les consultations d'un médecin (généraliste)
    public List<Consultation> findByDoctorId(int doctorId) {
        try {
            String jpql = "SELECT c FROM Consultation c " +
                    "WHERE c.generalist.id = :doctorId " +
                    "ORDER BY c.createdAt DESC";

            return em.createQuery(jpql, Consultation.class)
                    .setParameter("doctorId", doctorId)
                    .getResultList();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la récupération des consultations: " + e.getMessage(), e);
        }
    }

    // Récupérer les consultations avec filtrage par statut
    public List<Consultation> findByDoctorIdAndStatus(int doctorId, ConsultationStatus status) {
        try {
            String jpql = "SELECT c FROM Consultation c " +
                    "WHERE c.generalist.id = :doctorId AND c.consultationStatus = :status " +
                    "ORDER BY c.createdAt DESC";

            return em.createQuery(jpql, Consultation.class)
                    .setParameter("doctorId", doctorId)
                    .setParameter("status", status)
                    .getResultList();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la récupération des consultations filtrées: " + e.getMessage(), e);
        }
    }

    // Sauvegarder une consultation
    public void save(Consultation consultation) {
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.persist(consultation);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw new RuntimeException("Erreur lors de la sauvegarde de la consultation: " + e.getMessage(), e);
        }
    }

    // Mettre à jour une consultation
    public void update(Consultation consultation) {
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.merge(consultation);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw new RuntimeException("Erreur lors de la mise à jour de la consultation: " + e.getMessage(), e);
        }
    }

    public Consultation findPendingConsultationByPatientAndGeneralist(int patientId, int generalistId) {
        try {
            String jpql = "SELECT c FROM Consultation c " +
                    "WHERE c.medicaleFile.patient.id = :patientId " +
                    "AND c.generalist.id = :generalistId " +
                    "AND c.consultationStatus = :status " +
                    "ORDER BY c.createdAt DESC";

            List<Consultation> consultations = em.createQuery(jpql, Consultation.class)
                    .setParameter("patientId", patientId)
                    .setParameter("generalistId", generalistId)
                    .setParameter("status", ConsultationStatus.WAITING)
                    .getResultList();

            return consultations.isEmpty() ? null : consultations.get(0);
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la recherche de consultation en attente: " + e.getMessage(), e);
        }
    }
}
