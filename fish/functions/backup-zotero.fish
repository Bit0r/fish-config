function backup-zotero -d "Backup Zotero configuration to a tarball"
    # 该函数用于备份 Zotero 的配置文件和数据库
    # 用法：backup-zotero
    # 恢复备份文件：tar -xvf zotero.tzst -C ~

    tar -cavf zotero.tzst -C ~ .zotero Zotero
end
