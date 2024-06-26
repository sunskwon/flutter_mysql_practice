package com.nowhere.be.controller;

import com.nowhere.be.model.dto.MenuDTO;
import com.nowhere.be.model.dto.ResponseMessage;
import com.nowhere.be.model.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.Map;

@RestController
public class MenuController {

    private MenuService menuService;

    @Autowired
    public MenuController(MenuService menuService) {
        this.menuService = menuService;
    }

    // 메뉴 전체 조회
    @GetMapping("/menus")
    public ResponseEntity<ResponseMessage> selectAllMenus() {

        // 응답 헤더 설정
        HttpHeaders headers = new HttpHeaders();

        headers.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));

        // 응답 데이터 설정
        Map<String, Object> responseMap = new HashMap<>();
        responseMap.put("menus", menuService.selectAllMenus());

        ResponseMessage responseMessage = new ResponseMessage(200, "조회 성공", responseMap);

        return new ResponseEntity<>(responseMessage, headers, HttpStatus.OK);
    }

    @GetMapping("/menus/{menuCode}")
    public ResponseEntity<ResponseMessage> selectMenuByCode(@PathVariable int menuCode) {

        HttpHeaders headers = new HttpHeaders();

        headers.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));

        Map<String, Object> responseMap = new HashMap<>();
        responseMap.put("menu", menuService.selectMenuByCode(menuCode));

        ResponseMessage responseMessage = new ResponseMessage(200, "조회 성공", responseMap);

        return new ResponseEntity<>(responseMessage, headers, HttpStatus.OK);
    }

    @PostMapping("/menus")
    public ResponseEntity<?> insertMenu(@RequestBody MenuDTO newMenu) {

        int newMenuCode = menuService.getLastMenuCode() + 1;

        newMenu.setMenuCode(newMenuCode);

        menuService.insertMenu(newMenu);

        return ResponseEntity
                .created(URI.create("/menus/" + newMenuCode))
                .build();
    }

    @PutMapping("/menus")
    public ResponseEntity<?> updateMenu(@RequestBody MenuDTO menu) {

        System.out.println("menu = " + menu);
        int menuCode = menu.getMenuCode();

        menuService.updateMenu(menu);

        return ResponseEntity
                .created(URI.create("/menus/" + menuCode))
                .build();
    }

    @DeleteMapping("/menus/{menuCode}")
    public ResponseEntity<?> deleteMenu(@PathVariable int menuCode) {

        menuService.deleteMenu(menuCode);

        return ResponseEntity.noContent().build();
    }
}
