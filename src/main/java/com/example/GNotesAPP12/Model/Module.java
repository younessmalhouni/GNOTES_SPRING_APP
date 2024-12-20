package com.example.GNotesAPP12.Model;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "module")
public class Module {

    @Id
    @Column(name = "code_module")
    private String codeModule;

    @Column(name = "nom_module", nullable = false)
    private String nomModule;

    @OneToMany(mappedBy = "module", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Element> elements;

    @OneToMany(mappedBy = "module", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<NoteModule> noteModules;

    @ManyToOne
    @JoinColumn(name = "filliere_id", nullable = false)
    private Filliere filliere;

    @ManyToOne
    @JoinColumn(name = "id_semestre", nullable = false)
    private Semestre semestre;

    // Default constructor
    public Module() {

    }

    // Getters and Setters
    public String getCodeModule() {
        return codeModule;
    }

    public void setCodeModule(String codeModule) {
        this.codeModule = codeModule;
    }

    public String getNomModule() {
        return nomModule;
    }

    public void setNomModule(String nomModule) {
        this.nomModule = nomModule;
    }

    public Semestre getSemestre() {
        return semestre;
    }

    public void setSemestre(Semestre semestre) {
        this.semestre = semestre;
    }

    public List<Element> getElements() {
        return elements;
    }

    public void setElements(List<Element> elements) {
        this.elements = elements;
    }

    public List<NoteModule> getNoteModules() {
        return noteModules;
    }

    public void setNoteModules(List<NoteModule> noteModules) {
        this.noteModules = noteModules;
    }

    public Filliere getFilliere() {
        return filliere;
    }

    public void setFilliere(Filliere filliere) {
        this.filliere = filliere;
    }

    // Constructors
    public Module(String codeModule, String nomModule, List<Element> elements, List<NoteModule> noteModules, Filliere filliere, Semestre semestre) {
        this.codeModule = codeModule;
        this.nomModule = nomModule;
        this.elements = elements;
        this.noteModules = noteModules;
        this.filliere = filliere;
        this.semestre = semestre;
    }


}
