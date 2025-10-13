<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" encoding="UTF-8" indent="yes" />

    <xsl:template match="/">
        <html>
            <head>
                <meta charset="UTF-8" />
                <title>Quản lý bàn ăn</title>
                <style>
                    body {
                    font-family: Arial, sans-serif;
                    background-color: #f8f9fa;
                    margin: 0;
                    padding: 30px;
                    color: #222;
                    }

                    .container {
                    width: 85%;
                    margin: 0 auto;
                    background-color: #fff;
                    padding: 30px;
                    border-radius: 10px;
                    box-shadow: 0 0 10px rgba(0,0,0,0.1);
                    }

                    h2 {
                    background-color: #007bff;
                    color: white;
                    padding: 8px 12px;
                    border-radius: 5px;
                    margin-top: 40px;
                    margin-bottom: 10px;
                    }

                    table {
                    border-collapse: collapse;
                    width: 100%;
                    margin-bottom: 30px;
                    table-layout: fixed; /* ✅ cố định độ rộng các cột */
                    }

                    th, td {
                    border: 1px solid #555;
                    padding: 8px;
                    text-align: left;
                    word-wrap: break-word; /* ✅ tự xuống dòng nếu chữ dài */
                    }

                    th {
                    background-color: #f2f2f2;
                    }

                    tr:nth-child(even) {
                    background-color: #f9f9f9;
                    }

                    tr:hover {
                    background-color: #e9f3ff;
                    transition: background-color 0.2s ease;
                    }

                    p, strong {
                    font-size: 18px;
                    }
                </style>

            </head>
            <body>
                <div class="container">

                    <!-- 1️⃣ Danh sách tất cả bàn -->
                    <h2>1. Danh sách tất cả các bàn</h2>
                    <table>
                        <tr>
                            <th>STT</th>
                            <th>Số bàn</th>
                            <th>Tên bàn</th>
                        </tr>
                        <xsl:for-each select="QUANLY/BANS/BAN">
                            <tr>
                                <td>
                                    <xsl:value-of select="position()" />
                                </td>
                                <td>
                                    <xsl:value-of select="SOBAN" />
                                </td>
                                <td>
                                    <xsl:value-of select="TENBAN" />
                                </td>
                            </tr>
                        </xsl:for-each>
                    </table>

                    <!-- 2️⃣ Danh sách nhân viên -->
                    <h2>2. Danh sách các nhân viên</h2>
                    <table>
                        <tr>
                            <th>STT</th>
                            <th>Mã NV</th>
                            <th>Tên NV</th>
                            <th>SĐT</th>
                            <th>Địa chỉ</th>
                            <th>Giới tính</th>
                        </tr>
                        <xsl:for-each select="QUANLY/NHANVIENS/NHANVIEN">
                            <tr>
                                <td>
                                    <xsl:value-of select="position()" />
                                </td>
                                <td>
                                    <xsl:value-of select="MANV" />
                                </td>
                                <td>
                                    <xsl:value-of select="TENV" />
                                </td>
                                <td>
                                    <xsl:value-of select="SDT" />
                                </td>
                                <td>
                                    <xsl:value-of select="DIACHI" />
                                </td>
                                <td>
                                    <xsl:value-of select="GIOITINH" />
                                </td>
                            </tr>
                        </xsl:for-each>
                    </table>

                    <!-- 3️⃣ Danh sách món ăn -->
                    <h2>3. Danh sách các món ăn</h2>
                    <table>
                        <tr>
                            <th>STT</th>
                            <th>Mã món</th>
                            <th>Tên món</th>
                            <th>Giá</th>
                        </tr>
                        <xsl:for-each select="QUANLY/MONS/MON">
                            <tr>
                                <td>
                                    <xsl:value-of select="position()" />
                                </td>
                                <td>
                                    <xsl:value-of select="MAMON" />
                                </td>
                                <td>
                                    <xsl:value-of select="TENMON" />
                                </td>
                                <td>
                                    <xsl:value-of select="format-number(GIA,'#,###')" />
                                </td>
                            </tr>
                        </xsl:for-each>
                    </table>

                    <!-- 4️⃣ Thông tin NV02 -->
                    <h2>4. Thông tin của nhân viên NV02</h2>
                    <table>
                        <tr>
                            <th>Mã NV</th>
                            <th>Tên NV</th>
                            <th>SĐT</th>
                            <th>Địa chỉ</th>
                            <th>Giới tính</th>
                        </tr>
                        <xsl:for-each select="QUANLY/NHANVIENS/NHANVIEN[MANV='NV02']">
                            <tr>
                                <td>
                                    <xsl:value-of select="MANV" />
                                </td>
                                <td>
                                    <xsl:value-of select="TENV" />
                                </td>
                                <td>
                                    <xsl:value-of select="SDT" />
                                </td>
                                <td>
                                    <xsl:value-of select="DIACHI" />
                                </td>
                                <td>
                                    <xsl:value-of select="GIOITINH" />
                                </td>
                            </tr>
                        </xsl:for-each>
                    </table>

                    <!-- 5️⃣ Món có giá > 50,000 -->
                    <h2>5. Danh sách món ăn có giá > 50,000</h2>
                    <table>
                        <tr>
                            <th>STT</th>
                            <th>Tên món</th>
                            <th>Giá</th>
                        </tr>
                        <xsl:for-each select="QUANLY/MONS/MON[GIA &gt; 50000]">
                            <tr>
                                <td>
                                    <xsl:value-of select="position()" />
                                </td>
                                <td>
                                    <xsl:value-of select="TENMON" />
                                </td>
                                <td>
                                    <xsl:value-of select="format-number(GIA,'#,###')" />
                                </td>
                            </tr>
                        </xsl:for-each>
                    </table>

                    <!-- 6️⃣ Thông tin hóa đơn HD03 -->
                    <h2>6. Thông tin hóa đơn HD03</h2>
                    <table>
                        <tr>
                            <th>Tên nhân viên</th>
                            <th>Số bàn</th>
                            <th>Ngày lập</th>
                            <th>Tổng tiền</th>
                        </tr>
                        <xsl:for-each select="QUANLY/HOADONS/HOADON[SOHD='HD03']">
                            <tr>
                                <td>
                                    <xsl:value-of
                                        select="/QUANLY/NHANVIENS/NHANVIEN[MANV=current()/MANV]/TENV" />
                                </td>
                                <td>
                                    <xsl:value-of select="SOBAN" />
                                </td>
                                <td>
                                    <xsl:value-of select="NGAYLAP" />
                                </td>
                                <td>
                                    <xsl:value-of select="format-number(TONGTIEN,'#,###')" />
                                </td>
                            </tr>
                        </xsl:for-each>
                    </table>

                    <!-- 7️⃣ Tên món trong HD02 -->
                    <h2>7. Tên các món ăn trong hóa đơn HD02</h2>
                    <table>
                        <tr>
                            <th>STT</th>
                            <th>Tên món</th>
                        </tr>
                        <xsl:for-each select="QUANLY/HOADONS/HOADON[SOHD='HD02']/CTHDS/CTHD">
                            <tr>
                                <td>
                                    <xsl:value-of select="position()" />
                                </td>
                                <td>
                                    <xsl:value-of
                                        select="/QUANLY/MONS/MON[MAMON=current()/MAMON]/TENMON" />
                                </td>
                            </tr>
                        </xsl:for-each>
                    </table>

                    <!-- 8️⃣ Tên nhân viên lập HD02 -->
                    <h2>8. Tên nhân viên lập hóa đơn HD02</h2>
                    <table>
                        <tr>
                            <th>Tên nhân viên</th>
                        </tr>
                        <xsl:for-each select="QUANLY/HOADONS/HOADON[SOHD='HD02']">
                            <tr>
                                <td>
                                    <xsl:value-of
                                        select="/QUANLY/NHANVIENS/NHANVIEN[MANV=current()/MANV]/TENV" />
                                </td>
                            </tr>
                        </xsl:for-each>
                    </table>

                    <!-- 9️⃣ Đếm số bàn -->
                    <h2>9. Tổng số bàn</h2>
                    <table>
                        <tr>
                            <th>Chỉ tiêu</th>
                            <th>Kết quả</th>
                        </tr>
                        <tr>
                            <td>Tổng số bàn</td>
                            <td>
                                <xsl:value-of select="count(QUANLY/BANS/BAN)" />
                            </td>
                        </tr>
                    </table>

                    <!-- 🔟 Đếm số hóa đơn của NV01 -->
                    <h2>10. Số hóa đơn lập bởi NV01</h2>
                    <table>
                        <tr>
                            <th>Chỉ tiêu</th>
                            <th>Kết quả</th>
                        </tr>
                        <tr>
                            <td>Số hóa đơn do NV01 lập</td>
                            <td>
                                <xsl:value-of select="count(QUANLY/HOADONS/HOADON[MANV='NV01'])" />
                            </td>
                        </tr>
                    </table>


                    <!-- 11️⃣ Món từng bán cho bàn số 2 -->
                    <h2>11. Danh sách món từng bán cho bàn số 2</h2>
                    <table>
                        <tr>
                            <th>STT</th>
                            <th>Tên món</th>
                        </tr>
                        <xsl:for-each select="QUANLY/HOADONS/HOADON[SOBAN='2']/CTHDS/CTHD">
                            <tr>
                                <td>
                                    <xsl:value-of select="position()" />
                                </td>
                                <td>
                                    <xsl:value-of
                                        select="/QUANLY/MONS/MON[MAMON=current()/MAMON]/TENMON" />
                                </td>
                            </tr>
                        </xsl:for-each>
                    </table>

                    <!-- 12️⃣ Nhân viên lập hóa đơn cho bàn 3 -->
                    <h2>12. Nhân viên từng lập hóa đơn cho bàn số 3</h2>
                    <table>
                        <tr>
                            <th>STT</th>
                            <th>Tên nhân viên</th>
                        </tr>
                        <xsl:for-each select="QUANLY/HOADONS/HOADON[SOBAN='3']">
                            <tr>
                                <td>
                                    <xsl:value-of select="position()" />
                                </td>
                                <td>
                                    <xsl:value-of
                                        select="/QUANLY/NHANVIENS/NHANVIEN[MANV=current()/MANV]/TENV" />
                                </td>
                            </tr>
                        </xsl:for-each>
                    </table>

                    <!-- 13️⃣ Món được gọi nhiều hơn 1 lần -->
                    <h2>13. Các món ăn được gọi nhiều hơn 1 lần</h2>
                    <table>
                        <tr>
                            <th>STT</th>
                            <th>Tên món</th>
                        </tr>
                        <xsl:for-each select="QUANLY/MONS/MON">
                            <xsl:variable name="ma" select="MAMON" />
<xsl:if
                                test="sum(/QUANLY/HOADONS/HOADON/CTHDS/CTHD[MAMON=$ma]/SOLUONG) &gt; 1">
                                <tr>
                                    <td>
                                        <xsl:value-of select="position()" />
                                    </td>
                                    <td>
                                        <xsl:value-of select="TENMON" />
                                    </td>
                                </tr>
                            </xsl:if>
                        </xsl:for-each>
                    </table>

                    <!-- 14️⃣ Chi tiết hóa đơn HD04 -->
                    <h2>14. Hóa đơn chi tiết tính tiền cho HD04</h2>
                    <table>
                        <tr>
                            <th>STT</th>
                            <th>Mã món</th>
                            <th>Tên món</th>
                            <th>Đơn giá</th>
                            <th>Số lượng</th>
                            <th>Tiền</th>
                        </tr>
                        <xsl:for-each select="QUANLY/HOADONS/HOADON[SOHD='HD04']/CTHDS/CTHD">
                            <xsl:variable name="ma" select="MAMON" />
<tr>
                                <td>
                                    <xsl:value-of select="position()" />
                                </td>
                                <td>
                                    <xsl:value-of select="$ma" />
                                </td>
                                <td>
                                    <xsl:value-of select="/QUANLY/MONS/MON[MAMON=$ma]/TENMON" />
                                </td>
                                <td>
                                    <xsl:value-of
                                        select="format-number(/QUANLY/MONS/MON[MAMON=$ma]/GIA,'#,###')" />
                                </td>
                                <td>
                                    <xsl:value-of select="SOLUONG" />
                                </td>
                                <td>
                                    <xsl:value-of
                                        select="format-number(/QUANLY/MONS/MON[MAMON=$ma]/GIA * SOLUONG,'#,###')" />
                                </td>
                            </tr>
                        </xsl:for-each>
                    </table>

                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>