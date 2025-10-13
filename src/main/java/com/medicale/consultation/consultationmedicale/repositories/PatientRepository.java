package com.medicale.consultation.consultationmedicale.repositories;

import com.medicale.consultation.consultationmedicale.models.person.Patient;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
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

    public Patient findByFirstAndLastName(String firstname, String lastname) {
        try {
            TypedQuery<Patient> query = em.createQuery("SELECT p FROM Patient p WHERE p.firstName = :firstname AND p.lastName = :lastname", Patient.class);
            query.setParameter("firstname", firstname);
            query.setParameter("lastname", lastname);

            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    public List<Patient> findAll() {
        TypedQuery<Patient> query = em.createQuery("SELECT p FROM Patient p", Patient.class);
        return query.getResultList();
    }
}
