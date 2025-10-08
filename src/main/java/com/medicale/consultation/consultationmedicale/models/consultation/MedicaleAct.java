package com.medicale.consultation.consultationmedicale.models.consultation;

import jakarta.persistence.*;

@Entity
@Table(name = "medicaleActs")
public class MedicaleAct {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false)
    private String label;

    @Column(nullable = false, precision = 10, scale = 2)
    private double price;

    @ManyToOne
    @JoinColumn(name = "consultation_id")
    private Consultation consultation;

    public MedicaleAct(int id, String label, double price) {
        this.id = id;
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
}
