Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objPDFMerger = CreateObject("AcroExch.PDDoc")

' diretório onde os arquivos PDF estão localizados
pdf_dir = "C:\Temp\PDF\"

' lista todos os arquivos PDF no diretório
Set pdf_files = objFSO.GetFolder(pdf_dir).Files
pdf_count = 0
For Each objFile In pdf_files
    If objFSO.GetExtensionName(objFile.Name) = "pdf" Then
        If pdf_count = 0 Then
            ' abre o primeiro arquivo PDF como documento base
            objPDFMerger.Open(objFile.Path)
        Else
            ' combina os arquivos PDF restantes ao documento base
            Set objPDFDocument = CreateObject("AcroExch.PDDoc")
            objPDFDocument.Open(objFile.Path)
            objPDFMerger.InsertPages objPDFMerger.GetNumPages - 1, objPDFDocument, 0, objPDFDocument.GetNumPages, False
            objPDFDocument.Close
        End If
        pdf_count = pdf_count + 1
    End If
Next

' nome do arquivo PDF combinado
filename = InputBox("Digite o nome do arquivo PDF combinado (sem a extensão .pdf):")
If filename <> "" Then
    ' salva o arquivo PDF combinado na pasta C:\Temp com o nome de arquivo especificado
    output_dir = "C:\Temp\"
    filename = filename & ".pdf"
    objPDFMerger.Save 1, output_dir & filename
    objPDFMerger.Close
    MsgBox "Arquivos PDF combinados com sucesso em " & output_dir & filename
End If
