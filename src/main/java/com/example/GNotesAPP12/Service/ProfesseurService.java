package com.example.GNotesAPP12.Service;

import com.example.GNotesAPP12.Model.Professeur;
import com.example.GNotesAPP12.Repo.ProfesseurRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProfesseurService {

    @Autowired
    private ProfesseurRepo professeurRepo;

    public List<Professeur> getAllProfesseurs() {
        return professeurRepo.findAll();
    }

    public Professeur getProfesseurById(String id) {
        return professeurRepo.findById(id).orElse(null);
    }

    public void saveProfesseur(Professeur professeur) {
        professeurRepo.save(professeur);
    }

    public void deleteProfesseur(String id) {
        professeurRepo.deleteById(id);
    }
}
