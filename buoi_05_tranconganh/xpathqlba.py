from lxml import etree

# Đọc dữ liệu từ file XML
tree = etree.parse("quanlybanan.xml")
root = tree.getroot()

# Danh sách truy vấn XPath
queries = {
    "1": ("Lấy tất cả bàn", "/QUANLY/BANS/BAN"),
    "2": ("Lấy tất cả nhân viên", "/QUANLY/NHANVIENS/NHANVIEN"),
    "3": ("Lấy tất cả tên món", "/QUANLY/MONS/MON/TENMON"),
    "4": (
        "Lấy tên nhân viên có mã NV02",
        "/QUANLY/NHANVIENS/NHANVIEN[MANV='NV02']/TENV",
    ),
    "5": (
        "Lấy tên và số điện thoại của nhân viên NV03",
        [
            "/QUANLY/NHANVIENS/NHANVIEN[MANV='NV03']/TENV",
            "/QUANLY/NHANVIENS/NHANVIEN[MANV='NV03']/SDT",
        ],
    ),
    "6": ("Lấy tên món có giá > 50,000", "/QUANLY/MONS/MON[GIA > 50000]/TENMON"),
    "7": ("Lấy số bàn của hóa đơn HD03", "/QUANLY/HOADONS/HOADON[SOHD='HD03']/SOBAN"),
    "8": ("Lấy tên món có mã M02", "/QUANLY/MONS/MON[MAMON='M02']/TENMON"),
    "9": (
        "Lấy ngày lập của hóa đơn HD03",
        "/QUANLY/HOADONS/HOADON[SOHD='HD03']/NGAYLAP",
    ),
    "10": (
        "Lấy tất cả mã món trong hóa đơn HD01",
        "/QUANLY/HOADONS/HOADON[SOHD='HD01']/CTHDS/CTHD/MAMON",
    ),
    "11": (
        "Lấy tên món trong hóa đơn HD01",
        "/QUANLY/MONS/MON[MAMON = /QUANLY/HOADONS/HOADON[SOHD='HD01']/CTHDS/CTHD/MAMON]/TENMON",
    ),
    "12": (
        "Lấy tên nhân viên lập hóa đơn HD02",
        "/QUANLY/NHANVIENS/NHANVIEN[MANV = /QUANLY/HOADONS/HOADON[SOHD='HD02']/MANV]/TENV",
    ),
    "13": ("Đếm số bàn", "count(/QUANLY/BANS/BAN)"),
    "14": ("Đếm số hóa đơn lập bởi NV01", "count(/QUANLY/HOADONS/HOADON[MANV='NV01'])"),
    "15": (
        "Lấy tên tất cả món có trong hóa đơn của bàn số 2",
        "/QUANLY/MONS/MON[MAMON = /QUANLY/HOADONS/HOADON[SOBAN=2]/CTHDS/CTHD/MAMON]/TENMON",
    ),
    "16": (
        "Lấy tất cả nhân viên từng lập hóa đơn cho bàn số 3",
        "/QUANLY/NHANVIENS/NHANVIEN[MANV = /QUANLY/HOADONS/HOADON[SOBAN=3]/MANV]",
    ),
    "17": (
        "Lấy tất cả hóa đơn mà nhân viên nữ lập",
        "/QUANLY/HOADONS/HOADON[MANV = /QUANLY/NHANVIENS/NHANVIEN[GIOITINH='Nữ']/MANV]",
    ),
    "18": (
        "Lấy tất cả nhân viên từng phục vụ bàn số 1",
        "/QUANLY/NHANVIENS/NHANVIEN[MANV = /QUANLY/HOADONS/HOADON[SOBAN=1]/MANV]",
    ),
    "19": (
        "Lấy tất cả món được gọi nhiều hơn 1 lần trong các hóa đơn",
        "/QUANLY/MONS/MON[MAMON = /QUANLY/HOADONS/HOADON/CTHDS/CTHD[SOLUONG > 1]/MAMON]",
    ),
    "20": (
        "Lấy tên bàn + ngày lập hóa đơn tương ứng SOHD='HD02'",
        "concat(/QUANLY/BANS/BAN[SOBAN = /QUANLY/HOADONS/HOADON[SOHD='HD02']/SOBAN]/TENBAN, ' - ', /QUANLY/HOADONS/HOADON[SOHD='HD02']/NGAYLAP)",
    ),
}

# Menu tương tác
while True:
    print("\n📋 MENU TRUY VẤN XPATH")
    for key, (desc, _) in queries.items():
        print(f"{key}. {desc}")
    print("0. Thoát")

    choice = input("\n👉 Chọn truy vấn (0 để thoát): ")
    if choice == "0":
        print("Tạm biệt Anh nhé!")
        break

    if choice in queries:
        desc, query = queries[choice]
        print(f"\n🔍 {desc}")
        if isinstance(query, list):
            for q in query:
                result = root.xpath(q)
                print(
                    f"Kết quả từ '{q}': {[r.text if hasattr(r, 'text') else r for r in result]}"
                )
        else:
            result = root.xpath(query)
            if isinstance(result, (float, int, str)):
                print("Kết quả:", result)
            elif isinstance(result, list):
                for item in result:
                    if isinstance(item, etree._Element):
                        print(
                            etree.tostring(item, pretty_print=True, encoding="unicode")
                        )
                    else:
                        print("Kết quả:", item)
            else:
                print("Kết quả:", result)
        input("\nNhấn Enter để tiếp tục...")
    else:
        print("⚠️ Lựa chọn không hợp lệ. Vui lòng thử lại.")
