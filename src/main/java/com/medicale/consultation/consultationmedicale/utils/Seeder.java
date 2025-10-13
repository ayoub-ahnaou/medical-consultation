package com.medicale.consultation.consultationmedicale.utils;

import com.medicale.consultation.consultationmedicale.enums.Gender;
import com.medicale.consultation.consultationmedicale.enums.Role;
import com.medicale.consultation.consultationmedicale.enums.Speciality;
import com.medicale.consultation.consultationmedicale.models.consultation.MedicaleAct;
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

            em.persist(new Nurse("Alice", "Smith", "nurse1", PasswordUtils.hashPassword("1234"),"0612345678", Gender.FEMALE, Role.NURSE));
            em.persist(new Nurse("Bob", "Brown", "nurse2", PasswordUtils.hashPassword("1234"),"0612345679", Gender.MALE, Role.NURSE));
            em.persist(new Nurse("Carol", "Johnson", "nurse3", PasswordUtils.hashPassword("1234"),"0612345680", Gender.FEMALE, Role.NURSE));
            em.persist(new Nurse("Diana", "King", "nurse4", PasswordUtils.hashPassword("1234"), "0612345681", Gender.FEMALE, Role.NURSE));
            em.persist(new Nurse("Ethan", "Wright", "nurse5", PasswordUtils.hashPassword("1234"), "0612345682", Gender.MALE, Role.NURSE));

            em.persist(new Generalist("John", "Doe", "generalist1", PasswordUtils.hashPassword("1234"), "0623456780", Gender.MALE, Role.GENERALIST, "RPPS001", "12 Main St", "Casablanca", 300.0));
            em.persist(new Generalist("Emma", "White", "generalist2", PasswordUtils.hashPassword("1234"), "0623456781", Gender.FEMALE, Role.GENERALIST, "RPPS002", "45 Elm St", "Rabat", 280.0));
            em.persist(new Generalist("Liam", "Scott", "generalist3", PasswordUtils.hashPassword("1234"), "0623456783", Gender.MALE, Role.GENERALIST, "RPPS003", "12 Boulevard", "Fes", 280.0));
            em.persist(new Generalist("Sophia", "Adams", "generalist4", PasswordUtils.hashPassword("1234"), "0623456784", Gender.FEMALE, Role.GENERALIST, "RPPS004", "98 Street", "Marrakech", 320.0));

            em.persist(new Specialist("Michael", "Lee", "specialist1", PasswordUtils.hashPassword("1234"), "0634567890", Gender.MALE, Role.SPECIALIST, "RPPS101", Speciality.CARDIOLOGY, 500.0));
            em.persist(new Specialist("Olivia", "Davis", "specialist2", PasswordUtils.hashPassword("1234"), "0634567891", Gender.FEMALE, Role.SPECIALIST, "RPPS102", Speciality.DERMATOLOGY, 450.0));
            em.persist(new Specialist("William", "Taylor", "specialist3", PasswordUtils.hashPassword("1234"), "0634567892", Gender.MALE, Role.SPECIALIST, "RPPS103", Speciality.NEUROLOGY, 550.0));
            em.persist(new Specialist("Isabella", "Martinez", "specialist4", PasswordUtils.hashPassword("1234"), "0634567893", Gender.FEMALE, Role.SPECIALIST, "RPPS104", Speciality.FAMILY, 550.0));
            em.persist(new Specialist("Alexander", "Harris", "specialist5", PasswordUtils.hashPassword("1234"), "0634567894", Gender.MALE, Role.SPECIALIST, "RPPS105", Speciality.NEUROLOGY, 450.0));

            // persist medical acts also into database
            em.persist(new MedicaleAct("General Consultation", 50.0));
            em.persist(new MedicaleAct("Specialist Consultation", 80.0));
            em.persist(new MedicaleAct("Blood Test - Complete Blood Count", 25.0));
            em.persist(new MedicaleAct("X-Ray - Chest", 45.0));
            em.persist(new MedicaleAct("MRI Scan - Brain", 300.0));
            em.persist(new MedicaleAct("CT Scan - Abdomen", 250.0));
            em.persist(new MedicaleAct("Ultrasound - Abdominal", 120.0));
            em.persist(new MedicaleAct("Vaccination - Influenza", 30.0));
            em.persist(new MedicaleAct("Minor Surgery - Suturing", 150.0));
            em.persist(new MedicaleAct("Dental Checkup and Cleaning", 60.0));
            em.persist(new MedicaleAct("Eye Examination - Comprehensive", 55.0));
            em.persist(new MedicaleAct("Physical Therapy Session", 75.0));
            em.persist(new MedicaleAct("ECG - Electrocardiogram", 40.0));
            em.persist(new MedicaleAct("Urine Analysis", 15.0));
            em.persist(new MedicaleAct("Allergy Testing - Skin Prick", 90.0));
            em.persist(new MedicaleAct("Skin Biopsy", 110.0));
            em.persist(new MedicaleAct("Colonoscopy", 400.0));
            em.persist(new MedicaleAct("Endoscopy - Upper GI", 350.0));
            em.persist(new MedicaleAct("Echocardiogram", 200.0));
            em.persist(new MedicaleAct("Bone Density Test", 85.0));

            tx.commit();
            System.out.println("Records seeded successfully...");
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        }
    }
}
