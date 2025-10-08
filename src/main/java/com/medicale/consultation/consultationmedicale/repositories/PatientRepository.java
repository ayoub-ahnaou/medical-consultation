package com.medicale.consultation.consultationmedicale.repositories;

import com.medicale.consultation.consultationmedicale.models.person.Patient;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class PatientRepository {
    private EntityManager em;

    public PatientRepository(EntityManager em) {
        this.em = em;
    }

    public void save(Patient patient) {
        em.getTransaction().begin();
        em.persist(patient);
        em.getTransaction().commit();
    }

    public Patient findById(int id) {
        return em.find(Patient.class, id);
    }

    public List<Patient> findAll() {
        TypedQuery<Patient> query = em.createQuery("SELECT p FROM Patient p", Patient.class);;
        return query.getResultList();
    }
}
