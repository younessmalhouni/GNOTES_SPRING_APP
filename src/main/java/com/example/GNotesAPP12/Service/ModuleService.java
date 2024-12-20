package com.example.GNotesAPP12.Service;

import com.example.GNotesAPP12.Model.Module;
import com.example.GNotesAPP12.Repo.ModuleRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ModuleService {

    @Autowired
    private ModuleRepo moduleRepo;

    public List<Module> getAllModules() {
        return moduleRepo.findAll();
    }

    public Module getModuleById(String id) {
        return moduleRepo.findById(id).orElse(null);
    }

    public void saveModule(Module module) {
        moduleRepo.save(module);
    }

    public void deleteModule(String id) {
        moduleRepo.deleteById(id);
    }




}
