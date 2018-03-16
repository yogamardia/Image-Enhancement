Imports System.Drawing
Imports System.Drawing.Graphics
Imports System.Drawing.Imaging
Public Class Form1

    Private Sub Open_File(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim ofd As New OpenFileDialog
        ofd.InitialDirectory = "c:\"
        ofd.Filter = "Image files (*.bmp, *.jpg)|*.bmp;*.jpg;*.png"
        If ofd.ShowDialog() = DialogResult.OK Then
            PictureBox1.Image = New Bitmap(ofd.FileName)
            PictureBox1.SizeMode = PictureBoxSizeMode.StretchImage
            PictureBox2.Image = Nothing
            PictureBox3.Image = Nothing
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
End Class
