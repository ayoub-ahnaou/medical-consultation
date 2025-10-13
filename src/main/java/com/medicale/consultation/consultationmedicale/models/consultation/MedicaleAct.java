package com.medicale.consultation.consultationmedicale.models.consultation;

import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "medicaleActs")
public class MedicaleAct {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false, unique = true)
    private String label;

    @Column(nullable = false)
    private double price;

    @ManyToMany(mappedBy = "medicaleActs")
    private List<Consultation> consultations = new ArrayList<>();

    public MedicaleAct(String label, double price) {
        this.label = label;
        this.price = price;
    }

    public MedicaleAct() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public List<Consultation> getConsultations() {
        return consultations;
    }

    public void setConsultations(List<Consultation> consultations) {
        this.consultations = consultations;
    }
}
