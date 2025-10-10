package com.medicale.consultation.consultationmedicale.models;

import com.medicale.consultation.consultationmedicale.models.consultation.Consultation;
import com.medicale.consultation.consultationmedicale.models.person.Patient;
import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "medicaleFiles")
public class MedicaleFile { // todo: update MedicaleFile typing to MedicalFile
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false)
    private double temperature;

    @Column(nullable = false)
    private int pulse;

    @Column(nullable = false, name = "respiratory_rate")
    private int bloodPresure;

    @Column(nullable = false)
    private int respiratoryRate;

    @Column(nullable = false, name = "oxygen_saturation")
    private double oxygenSaturation;

    @Column(nullable = false)
    private int pain;

    @OneToOne
    @JoinColumn(name = "patient_id", unique = true)
    private Patient patient;

    @ManyToOne
    @JoinColumn(name = "consultation_id")
    private Consultation consultation;

    @OneToMany(mappedBy = "medicaleFile", cascade = CascadeType.ALL)
    private List<Consultation> consultations = new ArrayList<>();

    public MedicaleFile(int id, double temperature, int pulse, int bloodPresure, int respiratoryRate, double oxygenSaturation, int pain) {
        this.id = id;
        this.temperature = temperature;
        this.pulse = pulse;
        this.bloodPresure = bloodPresure;
        this.respiratoryRate = respiratoryRate;
        this.oxygenSaturation = oxygenSaturation;
        this.pain = pain;
    }

    public MedicaleFile() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getTemperature() {
        return temperature;
    }

    public void setTemperature(double temperature) {
        this.temperature = temperature;
    }

    public int getPulse() {
        return pulse;
    }

    public void setPulse(int pulse) {
        this.pulse = pulse;
    }

    public int getBloodPresure() {
        return bloodPresure;
    }

    public void setBloodPresure(int bloodPresure) {
        this.bloodPresure = bloodPresure;
    }

    public int getRespiratoryRate() {
        return respiratoryRate;
    }

    public void setRespiratoryRate(int respiratoryRate) {
        this.respiratoryRate = respiratoryRate;
    }

    public double getOxygenSaturation() {
        return oxygenSaturation;
    }

    public void setOxygenSaturation(double oxygenSaturation) {
        this.oxygenSaturation = oxygenSaturation;
    }

    public int getPain() {
        return pain;
    }

    public void setPain(int pain) {
        this.pain = pain;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    public Consultation getConsultation() {
        return consultation;
    }

    public void setConsultation(Consultation consultation) {
        this.consultation = consultation;
    }

    public List<Consultation> getConsultations() {
        return consultations;
    }

    public void setConsultations(List<Consultation> consultations) {
        this.consultations = consultations;
    }
}
