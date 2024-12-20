package com.example.GNotesAPP12.Model;

import jakarta.persistence.*;

import java.util.List;

@Entity
public class Modalite_Evaluation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id_Modalite;
    private String type_Modalite;

    private double coeffecient;

    @ManyToOne
    @JoinColumn(name = "element_id")
    private Element element;

    @OneToMany(mappedBy = "modaliteEvaluation", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<NoteModalite> NoteModalites;

    // Getters and Setters
    public List<NoteModalite> getEtudiantModalites() {
        return NoteModalites;
    }

    public void setEtudiantModalites(List<NoteModalite> etudiantModalites) {
        this.NoteModalites = etudiantModalites;
    }
}

