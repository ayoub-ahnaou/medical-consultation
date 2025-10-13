package com.medicale.consultation.consultationmedicale.repositories;

import com.medicale.consultation.consultationmedicale.models.consultation.Consultation;
import jakarta.persistence.EntityManager;

import java.util.List;

public class ConsultationRepository {
    private EntityManager em;

    public ConsultationRepository(EntityManager em) {
        this.em = em;
    }

    public void save(Consultation consultation){
        em.getTransaction().begin();
        em.persist(consultation);
        em.getTransaction().commit();
    }

    public Consultation getConsultationById(int id){
        return em.find(Consultation.class, id);
    }

    public List<Consultation> findAll(){
        return em.createQuery("SELECT c FROM Consultation c", Consultation.class).getResultList();
    }

    public void update(Consultation consultation){
        em.getTransaction().begin();
        em.merge(consultation);
        em.getTransaction().commit();
    }
}
