package com.medicale.consultation.consultationmedicale.repositories;

import com.medicale.consultation.consultationmedicale.models.person.Nurse;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

public class NurseRepository {
    private EntityManager em;

    public NurseRepository(EntityManager em) {
        this.em = em;
    }

    public Nurse findByUsernameAndPassword(String username, String password) {
        try {
            TypedQuery<Nurse> query = em.createQuery(
                    "SELECT n FROM Nurse n WHERE n.username = :username AND n.password = :password",
                    Nurse.class
            );
            query.setParameter("username", username);
            query.setParameter("password", password);

            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }
}
