from lxml import etree

# Đọc file XML
tree = etree.parse("sv.xml")
root = tree.getroot()

# Danh sách truy vấn XPath (mô tả, câu XPath)
queries = {
    "1": ("Lấy tất cả sinh viên", "/school/student"),
    "2": ("Liệt kê tên tất cả sinh viên", "/school/student/name"),
    "3": ("Lấy tất cả id của sinh viên", "/school/student/id"),
    "4": (
        "Lấy ngày sinh của sinh viên có id = 'SV01'",
        "/school/student[id='SV01']/date",
    ),
    "5": ("Lấy các khóa học", "/school/enrollment/course"),
    "6": ("Lấy toàn bộ thông tin của sinh viên đầu tiên", "/school/student[1]"),
    "7": (
        "Lấy mã sinh viên đăng ký khóa học 'Vatly203'",
        "/school/enrollment[course='Vatly203']/studentRef",
    ),
    "8": (
        "Lấy tên sinh viên học môn 'Toan101'",
        "/school/student[id = /school/enrollment[course='Toan101']/studentRef]/name",
    ),
    "9": (
        "Lấy tên sinh viên học môn 'Vatly203'",
        "/school/student[id = /school/enrollment[course='Vatly203']/studentRef]/name",
    ),
    "10": (
        "Lấy ngày sinh của sinh viên có id='SV01'",
        "/school/student[id='SV01']/date",
    ),
    "11": (
        "Lấy tên và ngày sinh của sinh viên sinh năm 1997",
        "/school/student[starts-with(date, '1997')]/(name | date)",
    ),
    "12": (
        "Lấy tên sinh viên có ngày sinh trước năm 1998",
        "/school/student[date < '1998-01-01']/name",
    ),
    "13": ("Đếm tổng số sinh viên", "count(/school/student)"),
    "14": (
        "Lấy sinh viên chưa đăng ký môn nào",
        "/school/student[not(id = /school/enrollment/studentRef)]",
    ),
    "15": (
        "Lấy <date> ngay sau <name> của SV01",
        "/school/student[id='SV01']/name/following-sibling::date[1]",
    ),
    "16": (
        "Lấy <id> ngay trước <name> của SV02",
        "/school/student[id='SV02']/name/preceding-sibling::id[1]",
    ),
    "17": (
        "Lấy <course> trong enrollment có studentRef='SV03'",
        "/school/enrollment[studentRef='SV03']/course",
    ),
    "18": (
        "Lấy sinh viên có họ là 'Trần'",
        "/school/student[starts-with(name, 'Trần')]",
    ),
    "19": (
        "Lấy năm sinh của sinh viên SV01",
        "substring(/school/student[id='SV01']/date, 1, 4)",
    ),
}

# === Vòng lặp menu ===
while True:
    print("\n=== CHỌN TRUY VẤN XPATH CẦN CHẠY ===")
    for k, v in queries.items():
        print(f"{k}. {v[0]}")
    print("0. Thoát")

    # Người dùng chọn truy vấn
    choice = input("\nNhập số (0-19): ").strip()

    if choice == "0":
        print("👋 Kết thúc chương trình.")
        break

    elif choice in queries:
        desc, xpath_expr = queries[choice]
        print(f"\n👉 {desc}")
        result = root.xpath(xpath_expr)

        # Xử lý in kết quả
        if isinstance(result, (list, tuple)):
            if len(result) == 0:
                print("Không có kết quả.")
            else:
                for item in result:
                    if isinstance(item, etree._Element):
                        print(
                            etree.tostring(item, pretty_print=True, encoding="unicode")
                        )
                    else:
                        print(item)
        else:
            print(result)

        input("\nNhấn Enter để quay lại menu...")

    else:
        print("❌ Lựa chọn không hợp lệ.")
