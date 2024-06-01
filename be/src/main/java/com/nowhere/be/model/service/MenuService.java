package com.nowhere.be.model.service;

import com.nowhere.be.model.dao.MenuMapper;
import com.nowhere.be.model.dto.MenuDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MenuService {

    private MenuMapper menuMapper;

    @Autowired
    public MenuService (MenuMapper menuMapper) {
        this.menuMapper = menuMapper;
    }

    public List<MenuDTO> selectAllMenus() {
        return menuMapper.selectAllMenus();
    }

    public MenuDTO selectMenuByCode(int menuCode) {
        return menuMapper.selectMenuByCode(menuCode);
    }

    public int getLastMenuCode() {
        return menuMapper.getLastMenuCode();
    }

    public void insertMenu(MenuDTO newMenu) {
        menuMapper.insertMenu(newMenu);
    }
}
