<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes" />

    <!-- =================== TEMPLATE GỐC =================== -->
    <xsl:template match="/">
        <html>
            <head>
                <meta charset="UTF-8" />
                <title>Danh sách sinh viên</title>
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
                    table-layout: fixed; /* ✅ cột đều nhau */
                    }

                    th, td {
                    border: 1px solid #555;
                    padding: 8px;
                    text-align: left;
                    word-wrap: break-word; /* ✅ xuống dòng khi dài */
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
                    <!-- 1️⃣ Liệt kê mã và họ tên -->
                    <h2>1. thông tin của tất cả sinh viên</h2>
                    <table>
                        <tr>
                            <th>Mã SV</th>
                            <th>Họ tên</th>
                        </tr>
                        <xsl:apply-templates select="school/student" mode="info" />
                    </table>

                    <!-- 2️⃣ Mã, tên, điểm – sắp xếp giảm dần -->
                    <h2>2. Danh sách sinh viên sắp xếp theo điểm cao xuống thấp</h2>
                    <table>
                        <tr>
                            <th>Mã SV</th>
                            <th>Họ tên</th>
                            <th>Điểm</th>
                        </tr>
                        <xsl:apply-templates select="school/student">
                            <xsl:sort select="grade" data-type="number" order="descending" />
                        </xsl:apply-templates>
                    </table>

                    <!-- 3️⃣ Sinh tháng gần nhau -->
                    <h2>3. Danh sách sinh viên sinh tháng gần nhau</h2>
                    <table>
                        <tr>
                            <th>STT</th>
                            <th>Họ tên</th>
                            <th>Ngày sinh</th>
                        </tr>
                        <xsl:for-each select="school/student">
                            <xsl:sort select="substring(date,6,2)" data-type="number" />
            <xsl:apply-templates
                                select="." mode="birthday">
                                <xsl:with-param name="stt" select="position()" />
                            </xsl:apply-templates>
                        </xsl:for-each>
                    </table>

                    <!-- 4️⃣ Các khóa học có sinh viên học -->
                    <h2>4. Danh sách các khóa học có sinh viên học (sắp xếp theo tên khóa học)</h2>
                    <table>
                        <tr>
                            <th>Mã khóa học</th>
                            <th>Tên khóa học</th>
                        </tr>
                        <xsl:apply-templates select="school/course">
                            <xsl:sort select="name" />
                        </xsl:apply-templates>
                    </table>

                    <!-- 5️⃣ Sinh viên học khóa Hóa học 201 -->
                    <h2>5. Danh sách sinh viên học khóa hóa học 201</h2>
                    <table>
                        <tr>
                            <th>Mã SV</th>
                            <th>Họ tên</th>
                        </tr>
                        <xsl:apply-templates select="school/enrollment[courseRef='c3']"
                            mode="hoahoc" />
                    </table>

                    <!-- 6️⃣ Sinh viên sinh năm 1997 -->
                    <h2>6. Danh sách sinh viên sinh năm 1997</h2>
                    <table>
                        <tr>
                            <th>Mã SV</th>
                            <th>Họ tên</th>
                            <th>Năm sinh</th>
                        </tr>
                        <xsl:apply-templates select="school/student[starts-with(date,'1997')]"
                            mode="year1997" />
                    </table>

                    <!-- 7️⃣ Sinh viên họ Trần -->
                    <h2>7. Danh sách sinh viên họ “Trần”</h2>
                    <table>
                        <tr>
                            <th>Mã SV</th>
                            <th>Họ tên</th>
                        </tr>
                        <xsl:apply-templates select="school/student[starts-with(name,'Trần')]"
                            mode="tran" />
                    </table>

                </div>

            </body>
        </html>
    </xsl:template>

    <!-- =================== TEMPLATE PHỤ =================== -->

    <!-- 1. Template hiển thị mã và họ tên -->
    <xsl:template match="student" mode="info">
        <tr>
            <td>
                <xsl:value-of select="id" />
            </td>
            <td>
                <xsl:value-of select="name" />
            </td>
        </tr>
    </xsl:template>

    <!-- 2. Template hiển thị đầy đủ thông tin điểm -->
    <xsl:template match="student">
        <tr>
            <td>
                <xsl:value-of select="id" />
            </td>
            <td>
                <xsl:value-of select="name" />
            </td>
            <td>
                <xsl:value-of select="grade" />
            </td>
        </tr>
    </xsl:template>

    <!-- 3. Template cho sinh tháng gần nhau -->
    <xsl:template match="student" mode="birthday">
        <xsl:param name="stt" />
    <tr>
            <td>
                <xsl:value-of select="$stt" />
            </td>
            <td>
                <xsl:value-of select="name" />
            </td>
            <td>
                <xsl:value-of select="date" />
            </td>
        </tr>
    </xsl:template>

    <!-- 4. Template cho khóa học -->
    <xsl:template match="course">
        <tr>
            <td>
                <xsl:value-of select="id" />
            </td>
            <td>
                <xsl:value-of select="name" />
            </td>
        </tr>
    </xsl:template>

    <!-- 5. Template cho sinh viên học Hóa học 201 -->
    <xsl:template match="enrollment" mode="hoahoc">
        <xsl:variable name="sid" select="studentRef" />
    <tr>
            <td>
                <xsl:value-of select="$sid" />
            </td>
            <td>
                <xsl:value-of select="/school/student[id=$sid]/name" />
            </td>
        </tr>
    </xsl:template>

    <!-- 6. Template sinh năm 1997 -->
    <xsl:template match="student" mode="year1997">
        <tr>
            <td>
                <xsl:value-of select="id" />
            </td>
            <td>
                <xsl:value-of select="name" />
            </td>
            <td>
                <xsl:value-of select="substring(date,1,4)" />
            </td>
        </tr>
    </xsl:template>

    <!-- 7. Template họ Trần -->
    <xsl:template match="student" mode="tran">
        <tr>
            <td>
                <xsl:value-of select="id" />
            </td>
            <td>
                <xsl:value-of select="name" />
            </td>
        </tr>
    </xsl:template>

</xsl:stylesheet>