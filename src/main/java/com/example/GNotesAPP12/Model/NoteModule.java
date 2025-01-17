package com.example.GNotesAPP12.Model;

import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "note_module")
public class NoteModule {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "etudiant_id", nullable = false)
    private Etudiant etudiant;

    @ManyToOne
    @JoinColumn(name = "module_id", nullable = false)
    private Module module;

    @Column(name = "note_module", nullable = false)
    private Double noteModule;

    // Default constructor
    public NoteModule() {}

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Etudiant getEtudiant() {
        return etudiant;
    }

    public void setEtudiant(Etudiant etudiant) {
        this.etudiant = etudiant;
    }

    public Module getModule() {
        return module;
    }

    public void setModule(Module module) {
        this.module = module;
    }

    public Double getNoteModule() {
        return noteModule;
    }

    public void setNoteModule(Double noteModule) {
        this.noteModule = noteModule;
    }
}
