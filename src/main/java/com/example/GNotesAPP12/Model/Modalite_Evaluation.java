package com.example.GNotesAPP12.Model;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Modalite_Evaluation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id_Modalite;

    @Column(nullable = false)
    private String type_Modalite;

    @Column(nullable = false)
    private double coeffecient;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "element_id", referencedColumnName = "id_element")
    private Element element;

    @OneToMany(mappedBy = "modaliteEvaluation", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<NoteModalite> noteModalites = new ArrayList<>();

    // Getters and setters
    public Long getId_Modalite() {
        return id_Modalite;
    }

    public void setId_Modalite(Long id_Modalite) {
        this.id_Modalite = id_Modalite;
    }

    public String getType_Modalite() {
        return type_Modalite;
    }

    public void setType_Modalite(String type_Modalite) {
        this.type_Modalite = type_Modalite;
    }

    public double getCoeffecient() {
        return coeffecient;
    }

    public void setCoeffecient(double coeffecient) {
        this.coeffecient = coeffecient;
    }

    public Element getElement() {
        return element;
    }

    public void setElement(Element element) {
        this.element = element;
    }

    public List<NoteModalite> getNoteModalites() {
        return noteModalites;
    }

    public void setNoteModalites(List<NoteModalite> noteModalites) {
        this.noteModalites = noteModalites;
    }
}