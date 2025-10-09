package com.medicale.consultation.consultationmedicale.services.user;

import com.medicale.consultation.consultationmedicale.models.person.Generalist;
import com.medicale.consultation.consultationmedicale.models.person.Nurse;
import com.medicale.consultation.consultationmedicale.models.person.Person;
import com.medicale.consultation.consultationmedicale.models.person.Specialist;
import com.medicale.consultation.consultationmedicale.repositories.GeneralistRepository;
import com.medicale.consultation.consultationmedicale.repositories.NurseRepository;
import com.medicale.consultation.consultationmedicale.repositories.SpecialistRepository;
import com.medicale.consultation.consultationmedicale.utils.PasswordUtils;
import jakarta.persistence.EntityManager;

public class UserService {
    private NurseRepository nurseRepository;
    private GeneralistRepository generalistRepository;
    private SpecialistRepository specialistRepository;

    public UserService(EntityManager em) {
        this.nurseRepository = new NurseRepository(em);
        this.generalistRepository = new GeneralistRepository(em);
        this.specialistRepository = new SpecialistRepository(em);
    }

    // method to check if user with a username and password exists in database
    // I must check all three tables nurses, generalists and specialists (patient cannot log in)
    public Person authenticate(String username, String password) {

        // check in nurses table by NurseRepository class (findByUsernameAndPassword)
        Nurse nurse = nurseRepository.findByUsernameAndPassword(username);
        if (nurse != null && PasswordUtils.checkPassword(password, nurse.getPassword())) return nurse;

        // check in generalists table by GeneralistRepository class (findByUsernameAndPassword)
        Generalist generalist = generalistRepository.findByUsernameAndPassword(username);
        if (generalist != null && PasswordUtils.checkPassword(password, generalist.getPassword())) return generalist;

        // check in specialists table by SpecialistsRepository class (findByUsernameAndPassword)
        Specialist specialist = specialistRepository.findByUsernameAndPassword(username);
        if (specialist != null && PasswordUtils.checkPassword(password, specialist.getPassword())) return specialist;

        return null;
    }
}
