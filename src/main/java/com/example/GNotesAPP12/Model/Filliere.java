package com.example.GNotesAPP12.Model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

@Entity
public class Filliere {

    @Id
    @Column(name = "id_filliere")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idFilliere;

    private String nomFilliere;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date dateCreation;

    @Column
    private String description;

    @OneToMany(mappedBy = "filliere")
    private List<Etudiant> etudiants;

    @OneToMany(mappedBy = "filliere")
    private List<Module> modules;

    // Getters and Setters
    public Long getIdFilliere() {
        return idFilliere;
    }

    public void setIdFilliere(Long idFilliere) {
        this.idFilliere = idFilliere;
    }

    public String getNomFilliere() {
        return nomFilliere;
    }


    public void setNomFilliere(String nomFilliere) {
        this.nomFilliere = nomFilliere;
    }

    public Date getDateCreation() {
        return dateCreation;
    }

    public void setDateCreation(Date dateCreation) {
        this.dateCreation = dateCreation;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<Etudiant> getEtudiants() {
        return etudiants;
    }

    public void setEtudiants(List<Etudiant> etudiants) {
        this.etudiants = etudiants;
    }

    public List<Module> getModules() {
        return modules;
    }

    public void setModules(List<Module> modules) {
        this.modules = modules;
    }

    // Constructors
    public Filliere() {}

    public Filliere(Long idFilliere, String nomFilliere, Date dateCreation, String description) {
        this.idFilliere = idFilliere;
        this.nomFilliere = nomFilliere;
        this.dateCreation = dateCreation;
        this.description = description;
    }

}

