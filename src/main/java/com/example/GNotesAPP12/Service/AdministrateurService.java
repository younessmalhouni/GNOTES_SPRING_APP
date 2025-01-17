package com.example.GNotesAPP12.Service;

import com.example.GNotesAPP12.Repo.AdministrateurRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdministrateurService {

    @Autowired
    private AdministrateurRepo administrateurRepo;

    public Integer NbreProfesseurs() {
        return administrateurRepo.NbreTotalProfesseurs();
    }

    public Integer NbreEtudiants() {
        return administrateurRepo.NbreTotalEtudiant();
    }

    public Integer NbreFillieres() {
        return administrateurRepo.NbreDeFilliere();
    }

    public Integer NbreModules() {
        return administrateurRepo.NbreDeModule();
    }





}
