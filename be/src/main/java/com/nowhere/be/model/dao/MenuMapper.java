package com.nowhere.be.model.dao;

import com.nowhere.be.model.dto.MenuDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MenuMapper {
    List<MenuDTO> selectAllMenus();
}
