package com.medicale.consultation.consultationmedicale.utils;

import com.medicale.consultation.consultationmedicale.enums.Gender;
import com.medicale.consultation.consultationmedicale.enums.Role;
import com.medicale.consultation.consultationmedicale.enums.Speciality;
import com.medicale.consultation.consultationmedicale.models.person.Generalist;
import com.medicale.consultation.consultationmedicale.models.person.Nurse;
import com.medicale.consultation.consultationmedicale.models.person.Specialist;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.time.LocalDate;

public class Seeder {

    public static void seed(EntityManager em) {
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();

            em.persist(new Nurse(0, "Alice", "Smith", "nurse1", PasswordUtils.hashPassword("1234"),"0612345678", Gender.FEMALE, LocalDate.now(), Role.NURSE));
            em.persist(new Nurse(0, "Bob", "Brown", "nurse2", PasswordUtils.hashPassword("1234"),"0612345679", Gender.MALE, LocalDate.now(), Role.NURSE));
            em.persist(new Nurse(0, "Carol", "Johnson", "nurse3", PasswordUtils.hashPassword("1234"),"0612345680", Gender.FEMALE, LocalDate.now(), Role.NURSE));
            em.persist(new Nurse(0, "Diana", "King", "nurse4", PasswordUtils.hashPassword("1234"), "0612345681", Gender.FEMALE, LocalDate.now(), Role.NURSE));
            em.persist(new Nurse(0, "Ethan", "Wright", "nurse5", PasswordUtils.hashPassword("1234"), "0612345682", Gender.MALE, LocalDate.now(), Role.NURSE));

            em.persist(new Generalist(0, "John", "Doe", "generalist1", PasswordUtils.hashPassword("1234"), "0623456780", Gender.MALE, LocalDate.now(), Role.GENERALIST, "RPPS001", "12 Main St", "Casablanca", 300.0));
            em.persist(new Generalist(0, "Emma", "White", "generalist2", PasswordUtils.hashPassword("1234"), "0623456781", Gender.FEMALE, LocalDate.now(), Role.GENERALIST, "RPPS002", "45 Elm St", "Rabat", 280.0));
            em.persist(new Generalist(0, "Liam", "Scott", "generalist3", PasswordUtils.hashPassword("1234"), "0623456783", Gender.MALE, LocalDate.now(), Role.GENERALIST, "RPPS003", "12 Boulevard", "Fes", 280.0));
            em.persist(new Generalist(0, "Sophia", "Adams", "generalist4", PasswordUtils.hashPassword("1234"), "0623456784", Gender.FEMALE, LocalDate.now(), Role.GENERALIST, "RPPS004", "98 Street", "Marrakech", 320.0));

            em.persist(new Specialist(0, "Michael", "Lee", "specialist1", PasswordUtils.hashPassword("1234"), "0634567890", Gender.MALE, LocalDate.now(), Role.SPECIALIST, "RPPS101", Speciality.CARDIOLOGY, 500.0));
            em.persist(new Specialist(0, "Olivia", "Davis", "specialist2", PasswordUtils.hashPassword("1234"), "0634567891", Gender.FEMALE, LocalDate.now(), Role.SPECIALIST, "RPPS102", Speciality.DERMATOLOGY, 450.0));
            em.persist(new Specialist(0, "William", "Taylor", "specialist3", PasswordUtils.hashPassword("1234"), "0634567892", Gender.MALE, LocalDate.now(), Role.SPECIALIST, "RPPS103", Speciality.NEUROLOGY, 550.0));
            em.persist(new Specialist(0, "Isabella", "Martinez", "specialist4", PasswordUtils.hashPassword("1234"), "0634567893", Gender.FEMALE, LocalDate.now(), Role.SPECIALIST, "RPPS104", Speciality.FAMILY, 550.0));
            em.persist(new Specialist(0, "Alexander", "Harris", "specialist5", PasswordUtils.hashPassword("1234"), "0634567894", Gender.MALE, LocalDate.now(), Role.SPECIALIST, "RPPS105", Speciality.NEUROLOGY, 450.0));

            tx.commit();
            System.out.println("Users seeded successfully...");
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        }
    }
}
