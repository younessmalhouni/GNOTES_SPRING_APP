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

    public List<String> getAllSpecialities() {
        return professeurRepo.findAllSpecialities();
    }

    public List<Professeur> searchProfesseurs(String searchTerm, String specialite) {
        // If both parameters are empty or null, return all professors
        if ((searchTerm == null || searchTerm.trim().isEmpty()) &&
                (specialite == null || specialite.trim().isEmpty())) {
            return professeurRepo.findAll();
        }

        // Trim the search term if it exists
        String trimmedSearchTerm = searchTerm == null ? "" : searchTerm.trim();
        String trimmedSpecialite = specialite == null ? "" : specialite.trim();

        return professeurRepo.searchProfesseurs(trimmedSearchTerm, trimmedSpecialite);
    }
}
