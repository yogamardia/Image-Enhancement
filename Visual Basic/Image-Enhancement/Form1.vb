Imports System.Drawing
Imports System.Drawing.Graphics
Imports System.Drawing.Imaging
Public Class Form1
    Dim r, g, b As Integer 'membuat variabel a,r,g,b dengan tipe integer
    Dim brightness As Integer
    Dim valid As Integer
    Private Sub Open_File(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim ofd As New OpenFileDialog
        ofd.InitialDirectory = "c:\"
        ofd.Filter = "Image files (*.bmp, *.jpg)|*.bmp;*.jpg;*.png"
        If ofd.ShowDialog() = DialogResult.OK Then
            PictureBox1.Image = New Bitmap(ofd.FileName)
            PictureBox1.SizeMode = PictureBoxSizeMode.StretchImage
            PictureBox2.Image = Nothing
            PictureBox3.Image = Nothing
            brightValue.Value = 0
        End If
    End Sub

    Private Sub Grayscale(sender As Object, e As EventArgs) Handles Button2.Click
        If PictureBox1.Image Is Nothing Then
            MessageBox.Show("Please open the image first!", "Warning",
                            MessageBoxButtons.OK, MessageBoxIcon.Error)
        Else
            Dim source As New Bitmap(PictureBox1.Image)
            Dim red, green, blue, gray As Integer
            For y As Integer = 0 To source.Height - 1
                For x As Integer = 0 To source.Width - 1
                    red = source.GetPixel(x, y).R
                    green = source.GetPixel(x, y).G
                    blue = source.GetPixel(x, y).B
                    gray = (red + green + blue) / 3
                    source.SetPixel(x, y, Color.FromArgb(gray, gray, gray))
                Next
            Next
            PictureBox2.Image = source
            PictureBox2.SizeMode = PictureBoxSizeMode.StretchImage
        End If
    End Sub

    Private Sub Binary(sender As Object, e As EventArgs) Handles Button3.Click
        If PictureBox2.Image Is Nothing Then
            MessageBox.Show("Please grayscale the image first!", "Warning",
                            MessageBoxButtons.OK, MessageBoxIcon.Error)
        Else
            Dim source As New Bitmap(PictureBox2.Image)
            Dim red, green, blue, rgb As Integer
            For y As Integer = 0 To source.Height - 1
                For x As Integer = 0 To source.Width - 1
                    red = source.GetPixel(x, y).R
                    green = source.GetPixel(x, y).G
                    blue = source.GetPixel(x, y).B

                    rgb = red + green + blue

                    If rgb < 255 Then
                        source.SetPixel(x, y, Color.FromArgb(0, 0, 0))
                    Else
                        source.SetPixel(x, y, color.FromArgb(255, 255, 255))
                    End If
                Next
            Next
            PictureBox3.Image = source
            PictureBox3.SizeMode = PictureBoxSizeMode.StretchImage
        End If
    End Sub

    Private Sub Exit_Program(sender As Object, e As EventArgs) Handles Button4.Click
        Application.Exit()
    End Sub

    Private Sub minBright_Click(sender As Object, e As EventArgs) Handles minBright.Click
        brightValue.Maximum = 255
        brightValue.Minimum = -255
        If PictureBox1.Image Is Nothing Then 'membuat premis jika picbox tampilan2 tidak memuat gambar maka
            MessageBox.Show("Buka Gambar Terlebih Dahulu!", "Gagal Menggelapkan", MessageBoxButtons.OK, MessageBoxIcon.Warning) 'mengeluarkan pesan dan memberi tombol OK serta memunculkan ikon warning
        ElseIf PictureBox2.Image Is Nothing Then
            MessageBox.Show("Buka Gambar Terlebih Dahulu!", "Gagal Menggelapkan", MessageBoxButtons.OK, MessageBoxIcon.Warning)
        Else
            Dim source As New Bitmap(PictureBox2.Image)
            For y = 0 To source.Height - 1 'perulangan jika y = 0 menuju variabel h yang tingginya - 1 (karena koordinat 0 juga di hitung sehingga -1)
                For x = 0 To source.Width - 1 'perulangan jika x = 0 menuju variabel w yang lebarnya - 1 (karena koordinat 0 juga di hitung sehingga -1
                    Dim merah As Integer = source.GetPixel(x, y).R
                    Dim hijau As Integer = source.GetPixel(x, y).G
                    Dim biru As Integer = source.GetPixel(x, y).B

                    merah = merah - 50
                    hijau = hijau - 50
                    biru = biru - 50

                    If merah < 0 Then merah = 0
                    If hijau < 0 Then hijau = 0
                    If biru < 0 Then biru = 0

                    source.SetPixel(x, y, Color.FromArgb(merah, hijau, biru))
                Next
            Next
            If brightValue.Value = -250 Then
                MessageBox.Show("Gambarnya Udah Hitam Bro!", "Gagal Menggelapkan", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Else
                brightValue.Value = brightValue.Value - 50
            End If

            PictureBox2.Image = source
            PictureBox2.SizeMode = PictureBoxSizeMode.StretchImage
        End If
    End Sub

    Private Sub maxBright_Click(sender As Object, e As EventArgs) Handles maxBright.Click
        brightValue.Maximum = 255
        brightValue.Minimum = -255
        If PictureBox1.Image Is Nothing Then 'membuat premis jika picbox tampilan2 tidak memuat gambar maka
            MessageBox.Show("Buka Gambar Terlebih Dahulu!", "Gagal Menggelapkan", MessageBoxButtons.OK, MessageBoxIcon.Warning) 'mengeluarkan pesan dan memberi tombol OK serta memunculkan ikon warning
        ElseIf PictureBox2.Image Is Nothing Then
            MessageBox.Show("Buka Gambar Terlebih Dahulu!", "Gagal Menggelapkan", MessageBoxButtons.OK, MessageBoxIcon.Warning)
        Else
            Dim source As New Bitmap(PictureBox2.Image)
            For y = 0 To source.Height - 1 'perulangan jika y = 0 menuju variabel h yang tingginya - 1 (karena koordinat 0 juga di hitung sehingga -1)
                For x = 0 To source.Width - 1 'perulangan jika x = 0 menuju variabel w yang lebarnya - 1 (karena koordinat 0 juga di hitung sehingga -1
                    Dim merah As Integer = source.GetPixel(x, y).R
                    Dim hijau As Integer = source.GetPixel(x, y).G
                    Dim biru As Integer = source.GetPixel(x, y).B

                    merah = merah + 50
                    hijau = hijau + 50
                    biru = biru + 50

                    If merah > 255 Then merah = 255
                    If hijau > 255 Then hijau = 255
                    If biru > 255 Then biru = 255

                    source.SetPixel(x, y, Color.FromArgb(merah, hijau, biru))
                Next
            Next
            If brightValue.Value = 250 Then
                MessageBox.Show("Gambarnya Udah Terang Bro!", "Gagal Menggelapkan", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Else
                brightValue.Value = brightValue.Value + 50
            End If

            PictureBox2.Image = source
            PictureBox2.SizeMode = PictureBoxSizeMode.StretchImage
        End If
    End Sub
End Class
