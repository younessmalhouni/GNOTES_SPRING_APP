package com.example.GNotesAPP12.Model;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;

import java.util.List;

@Entity
public class Semestre {
    @Id
    private Long id_Semestre;
    private String nom_Semestre;

    public Semestre() {
    }

    public Semestre(Long id_Semestre, String nom_Semestre) {
        this.id_Semestre = id_Semestre;
        this.nom_Semestre = nom_Semestre;
    }

    public Long getId_Semestre() {
        return id_Semestre;
    }

    public void setId_Semestre(Long id_Semestre) {
        this.id_Semestre = id_Semestre;
    }

    public String getNom_Semestre() {
        return nom_Semestre;
    }

    public void setNom_Semestre(String nom_Semestre) {
        this.nom_Semestre = nom_Semestre;
    }

    @OneToMany(mappedBy = "semestre", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Module> modules;

    @OneToMany(mappedBy = "semestre", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Etudiant> etudiants;

    public List<Module> getModules() {
        return modules;
    }

    public void setModules(List<Module> modules) {
        this.modules = modules;
    }

    public List<Etudiant> getEtudiants() {
        return etudiants;
    }

    public void setEtudiants(List<Etudiant> etudiants) {
        this.etudiants = etudiants;
    }
}
