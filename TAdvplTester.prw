#Include 'Protheus.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} CallAdvplTester
Executa funções através da classe TAdvplTester para medir tempos
	
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Main Function CallAdvplTester()
Local oRunAdvpl := Nil
Local nTime   := 0

//Pega os segundos iniciais
nTime := Seconds()

//Printa no console o início dos testes
ConOut( "Begin: " + DtoC( Date() ) + Space( 1 ) + Time() )

//Instancia a classe e começa os testes
oRunAdvpl := TAdvplTester():New( 2500 , .F. )
oRunAdvpl:RunAll()

//Printa no console o final dos testes
ConOut( "End: " + DtoC( Date() ) + Space( 1 ) + Time() )

ConOut( "Total time: " + cValToChar( Seconds() - nTime ) )
ConOut( "" )
VarInfo( "Times:" , oRunAdvpl:GetTimes() )

oRunAdvpl:ExportResults()
oRunAdvpl:Destroy()
oRunAdvpl := Nil

Return Nil


//--------------------------------------------------Classe--------------------------------------------------//

//-------------------------------------------------------------------
/*/{Protheus.doc} TAdvplTester
Classe de teste de funções do binário,
guardando os tempos de execução
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Class TAdvplTester From LongNameClass
Data aTimes        As Array     //Guarda os tempos de execução das funções
Data nHowManyTimes As Numeric   //Guarda quantos testes serão executados
Data cFunctionName As Character //Guarda o nome da função que está sendo testada
Data lDoWhileTest  As Logical   //Guarda a informação se o teste deve ser efetuada com while também

//Métodos base da classe
Method New() //Constructor
Method Destroy() //Destructor
Method CleanArray()
Method UpdateTime()
Method GetTimes()
Method SetFunctionName()
Method GetFunctionName()
Method ExportResults()

//Métodos que executão os testes em blocos
Method RunAll()
Method RunArray()
Method RunDate()
Method RunString()
Method RunNumber()
Method RunConversion()
Method RunMathematic()
Method RunCodeBlock()
Method RunProcessing()
Method RunRPO()
Method RunOthers()

//Métodos de teste da classe

//Métodos...
Method TStaticCall()
Method TMacro()
Method TType()
Method TValType()
Method TAllwaysFalse()
Method TAllwaysTrue()
Method TIfString()
Method TIfNumber()
Method TIfDate()
Method TifBoolean()
Method TClassTest()

//Métodos de RPO
Method TChkRpoChg()
Method TGetApoInfo()
Method TGetApoRes()
Method TGetFuncArray()
Method TGetRpoLog()
Method TGetSrcArray()

//Métodos de processamento
Method TConOut()
Method TFindFunction()
Method TProcLine()
Method TProcName()
Method TSysRefresh()
Method TQOut()

//Métodos de bloco de código
Method TAEval()
Method TEval()
Method TGetCBSource()

//Métodos de array
Method TArray()
Method TAadd()
Method TAClone()
Method TACopy()
Method TADel()
Method TAFill()
Method TAIns()
Method TAScan()
Method TAScanX()
Method TASize()
Method TASort()
Method TATail()
Method TEmptyArray()
Method TLenArray()

//Métodos de data
Method TCDow()
Method TCMonth()
Method TDate()
Method TDay()
Method TDow()
Method TMonth()
Method TSeconds()
Method TTime()
Method TYear()

//Métodos de string
Method TAllTrim()
Method TAsc()
Method TAt()
Method TChr()
Method TEmptyString()
Method TLeft()
Method TLenString()
Method TLower()
Method TPad()
Method TRat()
Method TReplicate()
Method TRight()
Method TSpace()
Method TStrTokArr()
Method TStrTokArr2()
Method TStrTran()
Method TSubStr()
Method TTransform()
Method TTrim()
Method TUpper()
Method TConcat()

//Métodos de number
Method TAbs()
Method TInt()
Method TMax()
Method TMin()
Method TNoRound()
Method TRandomize()
Method TRound()

//Métodos matemáticos
Method TCeiling()
Method TExp()
Method TLog()
Method TLog10()
Method TMod()
Method TSqrt()

//Métodos de conversão
Method TCValToChar()
Method TDtoC()
Method TDtoS()
Method TCtoD()
Method TStoD()
Method TStr()
Method TStrZero()
Method TVal()

EndClass

//-------------------------------------------------------------------
/*/{Protheus.doc} New
Método construtor da classe
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method New( nHowManyTimes , lDoWhileTest ) Class TAdvplTester
Self:aTimes        := Array( 0 )
Self:cFunctionName := ''
Self:nHowManyTimes := 25000
Self:lDoWhileTest  := .T.

If nHowManyTimes != Nil
    Self:nHowManyTimes := Int( nHowManyTimes / 2 )
EndIf

If lDoWhileTest != Nil .And. !lDoWhileTest
    Self:nHowManyTimes *= 2
EndIf

Return Self

//-------------------------------------------------------------------
/*/{Protheus.doc} Destroy
Método de destruição da classe
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method Destroy() Class TAdvplTester
Local nLoop := 0

For nLoop := 1 To Len( Self:aTimes )
    Self:CleanArray( Self:aTimes[ nLoop ] )
Next

Self:CleanArray( Self:aTimes )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} CleanArray
Método de limpeza de arrays
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method CleanArray( aArray ) Class TAdvplTester
aSize( aArray , 0 )
aArray := Nil
Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} UpdateTime
Método de adição dos tempos de execução
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method UpdateTime( cLoop , cWhat ) Class TAdvplTester
Local nLen := 0

aAdd( Self:aTimes , { Self:GetFunctionName() , cLoop , cWhat , Seconds() } )

If cWhat == 'End'
    nLen := Len( Self:aTimes )
    aAdd( Self:aTimes , { Self:GetFunctionName() , cLoop , 'Total' , Self:aTimes[ nLen ][ 4 ] - Self:aTimes[ nLen - 1 ][ 4 ] } )
EndIf

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} GetTimes
Método que retorna o array de tempos
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method GetTimes() Class TAdvplTester
Return Self:aTimes

//-------------------------------------------------------------------
/*/{Protheus.doc} GetTimes
Método que seta o nome da função
@author Daniel Mendes de Melo Sousa
@since  27/06/2017
/*/
//-------------------------------------------------------------------
Method SetFunctionName( cFunction ) Class TAdvplTester
Self:cFunctionName := cFunction
Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} GetTimes
Método que retorna o nome da função
@author Daniel Mendes de Melo Sousa
@since  27/06/2017
/*/
//-------------------------------------------------------------------
Method GetFunctionName() Class TAdvplTester
Return Self:cFunctionName

//-------------------------------------------------------------------
/*/{Protheus.doc} ExportResults
Exporta os resultados do teste para um arquivo CSV
@author Daniel Mendes de Melo Sousa
@since  27/06/2017
/*/
//-------------------------------------------------------------------
Method ExportResults() Class TAdvplTester
Local nHandler  := 0
Local nWrite    := 0
Local cFileName := ''
Local lSaved    := .F.

If !Empty( Self:GetTimes() )
    //Gera um nome de arquivo com base na data e hora do server
    cFileName := StrTran( StrTran( StrTran( DtoS( Date() ) + Space( 1 ) + Time() + Space( 1 ) + cValToChar( Seconds() ) , '/' , '' ) , '.' , '' ) , ':' , '' ) + '.csv'
    nHandler  := FCreate( cFileName )

    If nHandler > -1
        If FWrite( nHandler , 'Function;Loop;Type;Time' + Chr(13) ) > -1
            aEval( Self:GetTimes()  , { | aTimes | nWrite := FWrite( nHandler , aTimes[ 1 ] + ';' + aTimes[ 2 ] + ';' + aTimes[ 3 ] + ';' + cValToChar( aTimes[ 4 ] ) + Chr( 13 ) ) } )
            lSaved := nWrite > -1
        EndIf
    EndIf
EndIf

Return lSaved

//-------------------------------------------------------------------
/*/{Protheus.doc} RunAll
Método que chama todos os testes presentes na classe
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method RunAll() Class TAdvplTester
Self:RunNumber()
Self:RunMathematic()
Self:RunDate()
Self:RunString()
Self:RunConversion()
Self:RunCodeBlock()
Self:RunProcessing()
Self:RunRPO()
Self:RunOthers()
Self:RunArray()
Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} RunArray
Método que chama todos os testes de array da classe
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method RunArray() Class TAdvplTester
Self:TAadd()
Self:TAClone()
Self:TACopy()
Self:TADel()
Self:TAFill()
Self:TAIns()
Self:TAScan()
Self:TAScanX()
Self:TASize()
Self:TASort()
Self:TATail()
Self:TEmptyArray()
Self:TLenArray()
Self:TArray()
Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} RunDate
Método que chama todos os testes de data da classe
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method RunDate() Class TAdvplTester
Self:TCDow()
Self:TCMonth()
Self:TDate()
Self:TDay()
Self:TDow()
Self:TMonth()
Self:TSeconds()
Self:TTime()
Self:TYear()
Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} RunString
Método que chama todos os testes de string da classe
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method RunString() Class TAdvplTester
Self:TAllTrim()
Self:TAsc()
Self:TAt()
Self:TChr()
Self:TEmptyString()
Self:TLeft()
Self:TLenString()
Self:TLower()
Self:TPad()
Self:TRat()
Self:TReplicate()
Self:TRight()
Self:TSpace()
Self:TStrTokArr()
Self:TStrTokArr2()
Self:TStrTran()
Self:TSubStr()
Self:TTransform()
Self:TTrim()
Self:TUpper()
Self:TConcat()
Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} RunNumber
Método que chama todos os testes de number da classe
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method RunNumber() Class TAdvplTester
Self:TAbs()
Self:TInt()
Self:TMax()
Self:TMin()
Self:TNoRound()
Self:TRandomize()
Self:TRound()
Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} RunConversion
Método que chama todos os testes de conversão da classe
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method RunConversion() Class TAdvplTester
Self:TCValToChar()
Self:TDtoC()
Self:TDtoS()
Self:TCtoD()
Self:TStoD()
Self:TStr()
Self:TStrZero()
Self:TVal()
Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} RunConversion
Método que chama todos os testes matemáticos da classe
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method RunMathematic() Class TAdvplTester
Self:TCeiling()
Self:TExp()
Self:TLog()
Self:TLog10()
Self:TMod()
Self:TSqrt()
Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} RunCodeBlock
Método que chama todos os testes de bloco de código
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method RunCodeBlock() Class TAdvplTester
Self:TAEval()
Self:TEval()
Self:TGetCBSource()
Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} RunProcessing
Método que chama todos os testes de processamento
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method RunProcessing() Class TAdvplTester
Self:TConOut()
Self:TFindFunction()
Self:TProcLine()
Self:TProcName()
Self:TSysRefresh()
Self:TQOut()
Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} RunRPO
Método que chama todos os testes de RPO
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method RunRPO() Class TAdvplTester
Self:TChkRpoChg()
Self:TGetApoInfo()
Self:TGetApoRes()
Self:TGetFuncArray()
//Self:TGetRpoLog() --Essa função não está podendo ser chamada!
Self:TGetSrcArray()
Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} RunOthers
Método que chama todos os demais testes
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method RunOthers() Class TAdvplTester
Self:TStaticCall()
Self:TMacro()
Self:TType()
Self:TValType()
Self:TAllwaysFalse()
Self:TAllwaysTrue()
Self:TIfString()
Self:TIfNumber()
Self:TIfDate()
Self:TifBoolean()
Self:TClassTest()
Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TStaticCall
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TStaticCall() Class TAdvplTester
Local nLoop := 0

Self:SetFunctionName( 'StaticCall' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    StaticCall( TAdvplTester , xFnc , Nil )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    StaticCall( TAdvplTester , xFnc , Nil )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TMacro
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TMacro() Class TAdvplTester
Local nLoop := 0
Local cMacr := ''

cMacr := ' Iif( .T. .And. .F. , .F. , .T. ) '

Self:SetFunctionName( 'Macro' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    &( cMacr )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    &( cMacr )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TType
@author Daniel Mendes de Melo Sousa
@since  27/06/2017
/*/
//-------------------------------------------------------------------
Method TType() Class TAdvplTester
Local nLoop := 0
Local cType := ''
Local cName := ''

cName := 'lNaoExiste'

Self:SetFunctionName( 'Type' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    cType := Type( cName )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    cType := Type( cName )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TValType
@author Daniel Mendes de Melo Sousa
@since  27/06/2017
/*/
//-------------------------------------------------------------------
Method TValType() Class TAdvplTester
Local nLoop := 0
Local cType := ''

Self:SetFunctionName( 'ValType' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    cType := ValType( nLoop )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    cType := ValType( nLoop )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TAllwaysFalse
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TAllwaysFalse() Class TAdvplTester
Local nLoop := 0
Local lRetn := .F.

Self:SetFunctionName( 'AllwaysFalse' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    lRetn := AllwaysFalse()
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    lRetn := AllwaysFalse()
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TAllwaysTrue
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TAllwaysTrue() Class TAdvplTester
Local nLoop := 0
Local lRetn := .F.

Self:SetFunctionName( 'AllwaysTrue' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    lRetn := AllwaysTrue()
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    lRetn := AllwaysTrue()
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TIfString
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TIfString() Class TAdvplTester
Local nLoop := 0
Local cVal1 := ''
Local cVal2 := ''

cVal1 := 'Aa Bb Cc Dd Ee Ff Gg Hh Ii Jj Kk Ll Mm Nn Oo Pp Qq Rr Ss | . ; : [] () {} = - + ! @ # $ % &'
cVal2 := 'Aa Bb Cc Dd Ee Ff Gg Hh Ii Jj Kk Ll Mm Nn Oo Pp Qq Rr Ss | . ; : [] () {} = - + ! @ # $ % ç'

Self:SetFunctionName( 'If - String' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    If cVal1 == cVal2
    EndIf
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    If cVal1 == cVal2
    EndIf

    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TIfNumber
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TIfNumber() Class TAdvplTester
Local nLoop := 0
Local nVal1 := 0
Local nVal2 := 0

nVal1 := 999999.123456
nVal2 := 999999.123455

Self:SetFunctionName( 'If - Numeric' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    If nVal1 == nVal2
    EndIf
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    If nVal1 == nVal2
    EndIf

    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TIfDate
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TIfDate() Class TAdvplTester
Local nLoop := 0
Local dVal1 := Nil
Local dVal2 := Nil

dVal1 := Date()
dVal2 := dVal1 + 1

Self:SetFunctionName( 'If - Date' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    If dVal1 == dVal2
    EndIf
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    If dVal1 == dVal2
    EndIf

    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TifBoolean
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TifBoolean() Class TAdvplTester
Local nLoop := 0
Local lVal  := .T.

Self:SetFunctionName( 'If - Boolean' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    If lVal
        lVal := .F.
    Else
        lVal := .T.
    EndIf
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    If lVal
        lVal := .F.
    Else
        lVal := .T.
    EndIf

    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TClassTest
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TClassTest() Class TAdvplTester
Local nLoop  := 0
Local oClass := Nil

oClass := TTesteAdvpl():New()

Self:SetFunctionName( 'Class' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    oClass:Teste()
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    oClass:Teste()
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

oClass := Nil

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TChkRpoChg
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TChkRpoChg() Class TAdvplTester
Local nLoop := 0
Local lRtrn := .F.

Self:SetFunctionName( 'ChkRpoChg' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    lRtrn := ChkRpoChg()
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    lRtrn := ChkRpoChg()
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TGetApoInfo
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TGetApoInfo() Class TAdvplTester
Local nLoop := 0
Local aData := Nil

Self:SetFunctionName( 'GetApoInfo' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    aData := GetApoInfo( 'TAdvplTester.prw' )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    aData := GetApoInfo( 'TAdvplTester.prw' )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )
Self:CleanArray( aData )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TGetApoRes
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TGetApoRes() Class TAdvplTester
Local nLoop  := 0
Local cResrc := ''

Self:SetFunctionName( 'GetApoRes' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    cResrc := GetApoRes( 'Test' )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    cResrc := GetApoRes( 'Test' )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TGetFuncArray
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TGetFuncArray() Class TAdvplTester
Local nLoop := 0
Local aType := {}
Local aFile := {}
Local aLine := {}
Local aDate := {}
Local aHour := {}
Local aSorc := Nil

Self:SetFunctionName( 'GetFuncArray' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    aSorc := GetFuncArray( 'TAdvpl*' , @aType , @aFile , @aLine , @aDate , @aHour )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    aSorc := GetFuncArray( 'TAdvpl*' , @aType , @aFile , @aLine , @aDate , @aHour )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )
Self:CleanArray( aSorc )
Self:CleanArray( aType )
Self:CleanArray( aFile )
Self:CleanArray( aLine )
Self:CleanArray( aDate )
Self:CleanArray( aHour )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TGetRpoLog
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TGetRpoLog() Class TAdvplTester
Local nLoop := 0
Local aData := Nil

Self:SetFunctionName( 'GetRpoLog' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    aData := GetRpoLog()
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    aData := GetRpoLog()
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )
Self:CleanArray( aData )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TGetSrcArray
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TGetSrcArray() Class TAdvplTester
Local nLoop := 0
Local aSrc  := Nil

Self:SetFunctionName( 'GetSrcArray' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    aSrc := GetSrcArray( 'TAdvpl*' )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    aSrc := GetSrcArray( 'TAdvpl*' )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )
Self:CleanArray( aSrc )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TConOut
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TConOut() Class TAdvplTester
Local nLoop  := 0
Local cValue := ''

cValue := ' Conouting... '

Self:SetFunctionName( 'ConOut' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    ConOut( cValue )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    ConOut( cValue )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TFindFunction
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TFindFunction() Class TAdvplTester
Local nLoop := 0
Local lExts := .F.

Self:SetFunctionName( 'FindFunction' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    lExts := FindFunction( 'FindFunction' )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    lExts := FindFunction( 'FindFunction' )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TProcLine
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TProcLine() Class TAdvplTester
Local nLoop := 0
Local nLine := 0

Self:SetFunctionName( 'ProcLine' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    nLine := ProcLine( 1 )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    nLine := ProcLine( 1 )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TProcName
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TProcName() Class TAdvplTester
Local nLoop := 0
Local cName := ''

Self:SetFunctionName( 'ProcName' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    cName := ProcName( 1 )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    cName := ProcName( 1 )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TSysRefresh
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TSysRefresh() Class TAdvplTester
Local nLoop := 0
Local lRfrs := .F.

Self:SetFunctionName( 'SysRefresh' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    lRfrs := SysRefresh()
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    lRfrs := SysRefresh()
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TQOut
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TQOut() Class TAdvplTester
Local nLoop  := 0
Local cValue := ''

cValue := ' QOuting... '

Self:SetFunctionName( 'QOut' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    QOut( cValue )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    QOut( cValue )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TAEval
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TAEval() Class TAdvplTester
Local nLoop := 0
Local aArry := Nil
Local bBlok := Nil

aArry := Array( 10 )
bBlok := { | aX | Iif( aX == 0 , .F. , .T. ) }
aFill( aArry , 0 )

Self:SetFunctionName( 'AEval' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    AEval( aArry , bBlok )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    AEval( aArry , bBlok )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TEval
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TEval() Class TAdvplTester
Local nLoop := 0
Local bBlok := Nil
Local lOk   := .F.

bBlok := { | x | Iif( x == 0 , .T. , .F. ) }

Self:SetFunctionName( 'Eval' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    lOk := Eval( bBlok , nLoop )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    lOk := Eval( bBlok , nLoop )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )
bBlok := Nil

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TGetCBSource
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TGetCBSource() Class TAdvplTester
Local nLoop := 0
Local cBlok := Nil
Local cText := ''

cBlok := { | a , b , c | ( ( a + b ) * c ) * nLoop }

Self:SetFunctionName( 'GetCBSource' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    cText := GetCBSource( cBlok )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    cText := GetCBSource( cBlok )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TArray
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TArray() Class TAdvplTester
Local aTest := Nil
Local nLoop := 0
Local nSize := 0

nSize := 5

Self:SetFunctionName( 'Array' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    aTest := Array( nSize )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    aTest := Array( nSize )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TAadd
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TAadd() Class TAdvplTester
Local aTest := {}
Local nLoop := 0
Local cChar := ''

cChar := Space( 10 )

Self:SetFunctionName( 'Add' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    aAdd( aTest , cChar )
Next

Self:UpdateTime( 'For' , 'End' )
Self:CleanArray( aTest )

aTest := {}
nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    aAdd( aTest , cChar )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )
Self:CleanArray( aTest )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TAClone
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TAClone() Class TAdvplTester
Local aTest := {}
Local aArry := Nil
Local nLoop := 0

Self:SetFunctionName( 'aClone' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    aArry := aClone( aTest )
    aArry := Nil
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    aArry := aClone( aTest )
    aArry := Nil
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )
Self:CleanArray( aTest )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TACopy
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TACopy() Class TAdvplTester
Local aTest := Array( 5 )
Local aArry := Array( 5 )
Local nLoop := 0

Self:SetFunctionName( 'aCopy' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    aCopy( aTest , aArry )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    aCopy( aTest , aArry )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Self:CleanArray( aTest )
Self:CleanArray( aArry )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TADel
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TADel() Class TAdvplTester
Local aTest := Nil
Local nLoop := 0
Local nMax  := 0

nMax  := Self:nHowManyTimes - 1
aTest := Array( Self:nHowManyTimes )

Self:SetFunctionName( 'aDel' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 0 To nMax
    aDel( aTest , Self:nHowManyTimes - nLoop )
Next

Self:UpdateTime( 'For' , 'End' )
Self:CleanArray( aTest )

aTest := Array( Self:nHowManyTimes )
nLoop := 0

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= nMax
    aDel( aTest , Self:nHowManyTimes - nLoop )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )
Self:CleanArray( aTest )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TAFill
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TAFill() Class TAdvplTester
Local aTest := Nil
Local nLoop := 0
Local cChar := ''

aTest := Array( 10 )
cChar := Space( 10 )

Self:SetFunctionName( 'aFill' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 0 To Self:nHowManyTimes
    aFill( aTest , cChar )
Next

Self:UpdateTime( 'For' , 'End' )
Self:CleanArray( aTest )

aTest := Array( 10 )
nLoop := 0

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    aFill( aTest , cChar )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )
Self:CleanArray( aTest )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TAIns
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TAIns() Class TAdvplTester
Local nLoop := 0
Local aTest := Nil

aTest := Array( Self:nHowManyTimes )

Self:SetFunctionName( 'aIns' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    aIns( aTest , nLoop )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    aIns( aTest , nLoop )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )
Self:CleanArray( aTest )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TAScan
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TAScan() Class TAdvplTester
Local nLoop := 0
Local nPos  := 0
Local aTest := Nil
Local cFind := ''

//Prepara o array para o teste de busca
aTest := Array( 10 )
aFill( aTest , "A" )
aTest[ 7 ] := "B"
cFind      := aTest[ 7 ]

Self:SetFunctionName( 'aScan' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    nPos := aScan( aTest , cFind )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    nPos := aScan( aTest , cFind )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )
Self:CleanArray( aTest )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TAScanX
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TAScanX() Class TAdvplTester
Local nLoop := 0
Local nPos  := 0
Local aTest := Nil
Local bFind := Nil

//Prepara o array para o teste de busca
aTest      := Array( 10 )
aTest[ 7 ] := "B"
bFind      := { | x , y | x == "B" .And. y == 7 } 

aFill( aTest , "A" )

Self:SetFunctionName( 'aScanX' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    nPos := aScanX( aTest , bFind )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    nPos := aScanX( aTest , bFind )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )
Self:CleanArray( aTest )

bFind := Nil

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TASize
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TASize() Class TAdvplTester
Local aTest := Nil
Local nLoop := 0
Local nMax  := 0

nMax  := Self:nHowManyTimes - 1
aTest := Array( Self:nHowManyTimes )

Self:SetFunctionName( 'aSize' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 0 To nMax
    aSize( aTest , Self:nHowManyTimes - nLoop )
Next

Self:UpdateTime( 'For' , 'End' )
Self:CleanArray( aTest )

aTest := Array( Self:nHowManyTimes )
nLoop := 0

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= nMax
    aSize( aTest , Self:nHowManyTimes - nLoop )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )
Self:CleanArray( aTest )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TASort
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TASort() Class TAdvplTester
Local nLoop := 0
Local aTest := Nil

//Todo: Desordenar o array
aTest := Array( 10 )
aFill( aTest , "A" )
aTest[ 7 ] := "B"

Self:SetFunctionName( 'aSort' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    aSort( aTest )
Next

Self:UpdateTime( 'For' , 'End' )
Self:CleanArray( aTest )

nLoop := 1

//Todo: Desordenar o array
aTest := Array( 10 )
aFill( aTest , "A" )
aTest[ 7 ] := "B"

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    aSort( aTest )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )
Self:CleanArray( aTest )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TATail
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TATail() Class TAdvplTester
Local nLoop := 0
Local xLast := Nil
Local aTest := Nil

aTest := Array( 10 )

Self:SetFunctionName( 'aTail' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    xLast := aTail( aTest )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    xLast := aTail( aTest )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )
Self:CleanArray( aTest )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TEmptyArray
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TEmptyArray() Class TAdvplTester
Local nLoop  := 0
Local lEmpty := .F.
Local aTest  := Nil

aTest := Array( 10 )

Self:SetFunctionName( 'Empty - Array' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    lEmpty := Empty( aTest )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    lEmpty := Empty( aTest )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )
Self:CleanArray( aTest )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TLenArray
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TLenArray() Class TAdvplTester
Local nLoop := 0
Local nLen  := 0
Local aTest := Nil

aTest := Array( 10 )

Self:SetFunctionName( 'Len - Array' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    nLen := Len( aTest )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    nLen := Len( aTest )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )
Self:CleanArray( aTest )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TCDow
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TCDow() Class TAdvplTester
Local nLoop := 0
Local cDow  := ''
Local dDate := Nil

dDate := Date()

Self:SetFunctionName( 'CDow' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    cDow := CDow( dDate )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    cDow := CDow( dDate )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TCMonth
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TCMonth() Class TAdvplTester
Local nLoop  := 0
Local cMonth := ''
Local dDate  := Nil

dDate := Date()

Self:SetFunctionName( 'CMonth' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    cMonth := CMonth( dDate )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    cMonth := CMonth( dDate )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TDate
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TDate() Class TAdvplTester
Local nLoop := 0
Local dDate := Nil

Self:SetFunctionName( 'Date' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    dDate := Date()
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    dDate := Date()
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TDay
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TDay() Class TAdvplTester
Local nLoop := 0
Local nDay  := 0
Local dDate := Nil

dDate := Date()

Self:SetFunctionName( 'Day' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    nDay := Day( dDate )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    nDay := Day( dDate )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TDow
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TDow() Class TAdvplTester
Local nLoop := 0
Local nDow  := 0
Local dDate := Nil

dDate := Date()

Self:SetFunctionName( 'Dow' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    nDow := Dow( dDate )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    nDow := Dow( dDate )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TMonth
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TMonth() Class TAdvplTester
Local nLoop  := 0
Local nMonth := 0
Local dDate  := Nil

dDate := Date()

Self:SetFunctionName( 'Month' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    nMonth := Month( dDate )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    nMonth := Month( dDate )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TSeconds
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TSeconds() Class TAdvplTester
Local nLoop := 0
Local nSecs := ''

Self:SetFunctionName( 'Seconds' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    nSecs := Seconds()
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    nSecs := Seconds()
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TTime
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TTime() Class TAdvplTester
Local nLoop := 0
Local cTime := ''

Self:SetFunctionName( 'Time' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    cTime := Time()
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    cTime := Time()
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TYear
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TYear() Class TAdvplTester
Local nLoop := 0
Local nYear := 0
Local dDate := Nil

dDate := Date()

Self:SetFunctionName( 'Year' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    nYear := Year( dDate )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    nYear := Year( dDate )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TAllTrim
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TAllTrim() Class TAdvplTester
Local nLoop := 0
Local cText := ''
Local cTrim := ''

cText := ' Tester '

Self:SetFunctionName( 'AllTrim' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    cTrim := AllTrim( cText )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    cTrim := AllTrim( cText )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TAsc
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TAsc() Class TAdvplTester
Local nLoop  := 0
Local nValue := 0
Local cValue := ''

cValue := 'y'

Self:SetFunctionName( 'Asc' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    nValue := Asc( cValue )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    nValue := Asc( cValue )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TAt
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TAt() Class TAdvplTester
Local nLoop := 0
Local nAt   := 0
Local cText := ''
Local cChar := ''

cText := ' Tester '
cChar := 't'

Self:SetFunctionName( 'At' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    nAt := At( cChar , cText )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    nAt := At( cChar , cText )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TChr
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TChr() Class TAdvplTester
Local nLoop  := 0
Local nValue := 0
Local cValue := ''

nValue := Int( Randomize( 65 , 90 ) )

Self:SetFunctionName( 'Chr' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    cValue := Chr( nValue )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    cValue := Chr( nValue )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TEmptyString
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TEmptyString() Class TAdvplTester
Local nLoop  := 0
Local lEmpty := .F.
Local cText  := ''

cText := ' Tester '

Self:SetFunctionName( 'Empty - String' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    lEmpty := Empty( cText )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    lEmpty := Empty( cText )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TLeft
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TLeft() Class TAdvplTester
Local nLoop := 0
Local cText := ''
Local cRght := ''

cText := ' AbCdEfGh '

Self:SetFunctionName( 'Left' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    cRght := Left( cText , 6 )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    cRght := Left( cText , 6 )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TLenString
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TLenString() Class TAdvplTester
Local nLoop := 0
Local nLen  := 0
Local cText := ''

cText := ' Tester '

Self:SetFunctionName( 'Len - String' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    nLen := Len( cText )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    nLen := Len( cText )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TLower
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TLower() Class TAdvplTester
Local nLoop := 0
Local cText := ''
Local cLwr  := ''

cText := ' AABCDEFGHIJKL '

Self:SetFunctionName( 'Lower' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    cLwr := Lower( cText )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    cLwr := Lower( cText )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TPad
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TPad() Class TAdvplTester
Local nLoop := 0
Local nSize := 0
Local cText := ''
Local cPad  := ''

cText := 'Tester'
nSize := 10

Self:SetFunctionName( 'Pad' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    cPad := Pad( cText , nSize )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    cPad := Pad( cText , nSize )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TRat
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TRat() Class TAdvplTester
Local nLoop := 0
Local nAt   := 0
Local cText := ''
Local cChar := ''

cText := ' Tester '
cChar := 't'

Self:SetFunctionName( 'Rat' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    nAt := Rat( cChar , cText )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    nAt := Rat( cChar , cText )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TReplicate
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TReplicate() Class TAdvplTester
Local nLoop := 0
Local nVal  := 0
Local cVal  := ''
Local cRpct := ''

cVal := 'A'
nVal := 1024

Self:SetFunctionName( 'Replicate' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    cRpct := Replicate( cVal , nVal )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    cRpct := Replicate( cVal , nVal )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TRight
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TRight() Class TAdvplTester
Local nLoop := 0
Local cText := ''
Local cRght := ''

cText := ' AbCdEfGh '

Self:SetFunctionName( 'Right' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    cRght := Right( cText , 6 )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    cRght := Right( cText , 6 )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TSpace
@author Daniel Mendes de Melo Sousa
@since  27/06/2017
/*/
//-------------------------------------------------------------------
Method TSpace() Class TAdvplTester
Local nLoop := 0
Local nSize := 0
Local cSpac := ''

nSize := 1024

Self:SetFunctionName( 'Space' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    cSpac := Space( nSize )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    cSpac := Space( nSize )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TStrTokArr
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TStrTokArr() Class TAdvplTester
Local nLoop := 0
Local aArry := Nil
Local cText := ''

cText := 'A;B;C;D;E;F;G;H;I;K;;'

Self:SetFunctionName( 'StrTokArr' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    aArry := StrTokArr( cText , ';' )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    aArry := StrTokArr( cText , ';' )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )
Self:CleanArray( aArry )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TStrTokArr2
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TStrTokArr2() Class TAdvplTester
Local nLoop := 0
Local aArry := Nil
Local cText := ''

cText := 'A;B;C;D;E;F;G;H;I;K;;'

Self:SetFunctionName( 'StrTokArr2' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    aArry := StrTokArr2( cText , ';' , .T. )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    aArry := StrTokArr2( cText , ';' , .T. )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )
Self:CleanArray( aArry )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TStrTran
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TStrTran() Class TAdvplTester
Local nLoop := 0
Local nBegn := 0
Local nSize := 0
Local cText := ''
Local cStrT := ''

cText := ' Tester '
nBegn := 0
nSize := 0

Self:SetFunctionName( 'StrTran' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    cStrT := StrTran( cText , ' ' , '_' )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    cStrT := StrTran( cText , ' ' , '_' )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TSubStr
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TSubStr() Class TAdvplTester
Local nLoop := 0
Local nBegn := 0
Local nSize := 0
Local cText := ''
Local cSbst := ''

cText := ' Tester '
nBegn := 0
nSize := 0

Self:SetFunctionName( 'SubStr' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    cSbst := SubStr( cText , nBegn , nSize )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    cSbst := SubStr( cText , nBegn , nSize )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TTransform
@author Daniel Mendes de Melo Sousa
@since  27/06/2017
/*/
//-------------------------------------------------------------------
Method TTransform() Class TAdvplTester
Local nLoop := 0
Local nVal  := 0
Local cTrnf := ''
Local cMask := ''

nVal  := 9876543.5678
cMask := '@E 999,999,999.99'

Self:SetFunctionName( 'Transform' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    cTrnf := Transform( nVal , cMask )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    cTrnf := Transform( nVal , cMask )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TTrim
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TTrim() Class TAdvplTester
Local nLoop := 0
Local cText := ''
Local cTrim := ''

cText := ' Tester '

Self:SetFunctionName( 'Trim' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    cTrim := Trim( cText )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    cTrim := Trim( cText )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TUpper
@author Daniel Mendes de Melo Sousa
@since  27/06/2017
/*/
//-------------------------------------------------------------------
Method TUpper() Class TAdvplTester
Local nLoop := 0
Local cText := ''
Local cUppr := ''

cText := ' tester '

Self:SetFunctionName( 'Upper' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    cUppr := Upper( cText )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    cUppr := Upper( cText )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TConcat
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TConcat() Class TAdvplTester
Local nLoop := 0
Local cVal  := ''

Self:SetFunctionName( 'Concatenation' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    cVal += 'A'
Next

Self:UpdateTime( 'For' , 'End' )

cVal  := ''
nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    cVal += 'A'
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TAbs
@author Daniel Mendes de Melo Sousa
@since  27/06/2017
/*/
//-------------------------------------------------------------------
Method TAbs() Class TAdvplTester
Local nLoop := 0
Local nTest := 0
Local nAbs  := 0

nTest := -65535

Self:SetFunctionName( 'Abs' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    nAbs := Abs( nTest )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    nAbs := Abs( nTest )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TInt
@author Daniel Mendes de Melo Sousa
@since  27/06/2017
/*/
//-------------------------------------------------------------------
Method TInt() Class TAdvplTester
Local nLoop := 0
Local nInt  := 0
Local nVal  := 0

nVal := 3456789.98765

Self:SetFunctionName( 'Funcao' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    nInt := Int( nVal )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    nInt := Int( nVal )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TMax
@author Daniel Mendes de Melo Sousa
@since  27/06/2017
/*/
//-------------------------------------------------------------------
Method TMax() Class TAdvplTester
Local nLoop := 0
Local nTest := 0
Local nMax  := 0

nTest := 4987
 
Self:SetFunctionName( 'Max' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    nMax := Max( nTest , nLoop )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    nMax := Max( nTest , nLoop )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TMin
@author Daniel Mendes de Melo Sousa
@since  27/06/2017
/*/
//-------------------------------------------------------------------
Method TMin() Class TAdvplTester
Local nLoop := 0
Local nTest := 0
Local nMin  := 0

nTest := 4987
 
Self:SetFunctionName( 'Min' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    nMin := Min( nTest , nLoop )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    nMin := Min( nTest , nLoop )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TNoRound
@author Daniel Mendes de Melo Sousa
@since  27/06/2017
/*/
//-------------------------------------------------------------------
Method TNoRound() Class TAdvplTester
Local nLoop := 0
Local nTest := 0
Local nRnd  := 0
Local nDec  := 0

nTest := 7654321.981234
nDec  := 02

Self:SetFunctionName( 'NoRound' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    nRnd := NoRound( nTest , nDec )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    nRnd := NoRound( nTest , nDec )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TRandomize
@author Daniel Mendes de Melo Sousa
@since  27/06/2017
/*/
//-------------------------------------------------------------------
Method TRandomize() Class TAdvplTester
Local nLoop := 0
Local nRndz := 0
Local nBegn := 0

Self:SetFunctionName( 'Randomize' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    nRndz := Randomize( nBegn , nLoop )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    nRndz := Randomize( nBegn , nLoop )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TRound
@author Daniel Mendes de Melo Sousa
@since  27/06/2017
/*/
//-------------------------------------------------------------------
Method TRound() Class TAdvplTester
Local nLoop := 0
Local nTest := 0
Local nRnd  := 0
Local nDec  := 0

nTest := 7654321.981234
nDec  := 02

Self:SetFunctionName( 'Round' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    nRnd := Round( nTest , nDec )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    nRnd := Round( nTest , nDec )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TCeiling
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TCeiling() Class TAdvplTester
Local nLoop  := 0
Local nValue := 0
Local nClng  := 0

nValue := 9.12345678

Self:SetFunctionName( 'Ceiling' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    nClng := Ceiling( nValue )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    nClng := Ceiling( nValue )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TExp
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TExp() Class TAdvplTester
Local nLoop := 0
Local nExp  := 0

Self:SetFunctionName( 'Exp' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    nExp := Exp( nLoop )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    nExp := Exp( nLoop )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TLog
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TLog() Class TAdvplTester
Local nLoop := 0
Local nLog  := 0

Self:SetFunctionName( 'Log' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    nLog := Log( nLoop )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    nLog := Log( nLoop )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TLog10
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
Method TLog10() Class TAdvplTester
Local nLoop := 0
Local nLog  := 0

Self:SetFunctionName( 'Log10' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    nLog := Log10( nLoop )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    nLog := Log10( nLoop )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TMod
@author Daniel Mendes de Melo Sousa
@since  27/06/2017
/*/
//-------------------------------------------------------------------
Method TMod() Class TAdvplTester
Local nLoop := 0
Local nMod  := 0
Local nVal  := 0

nVal := 65535

Self:SetFunctionName( 'Mod' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    nMod := Mod( nVal , nLoop )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    nMod := Mod( nVal , nLoop )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TSqrt
@author Daniel Mendes de Melo Sousa
@since  27/06/2017
/*/
//-------------------------------------------------------------------
Method TSqrt() Class TAdvplTester
Local nLoop := 0
Local nSqrt := 0
Local nVal  := 0

nVal := 65535

Self:SetFunctionName( 'Sqrt' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    nSqrt := Sqrt( nLoop )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    nSqrt := Sqrt( nLoop )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TCValToChar
@author Daniel Mendes de Melo Sousa
@since  27/06/2017
/*/
//-------------------------------------------------------------------
Method TCValToChar() Class TAdvplTester
Local nLoop := 0
Local cVal  := ''

Self:SetFunctionName( 'CValToChar' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
     cVal := cValToChar( nLoop )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    cVal := cValToChar( nLoop )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TDtoC
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TDtoC() Class TAdvplTester
Local nLoop := 0
Local cDate  := 0
Local dDate := Nil

dDate := Date()

Self:SetFunctionName( 'DtoC' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    cDate := DtoC( dDate )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    cDate := DtoC( dDate )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TDtoS
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method TDtoS() Class TAdvplTester
Local nLoop := 0
Local cDate  := 0
Local dDate := Nil

dDate := Date()

Self:SetFunctionName( 'DtoS' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    cDate := DtoS( dDate )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    cDate := DtoS( dDate )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TCtoD
@author Daniel Mendes de Melo Sousa
@since  27/06/2017
/*/
//-------------------------------------------------------------------
Method TCtoD() Class TAdvplTester
Local nLoop := 0
Local dDate := Nil
Local cDate := ''

cDate := '01/01/2017'

Self:SetFunctionName( 'TCtoD' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    dDate := CtoD( cDate )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    dDate := CtoD( cDate )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TStoD
@author Daniel Mendes de Melo Sousa
@since  27/06/2017
/*/
//-------------------------------------------------------------------
Method TStoD() Class TAdvplTester
Local nLoop := 0
Local dDate := Nil
Local cDate := ''

cDate := '20010101'

Self:SetFunctionName( 'StoD' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    dDate := StoD( cDate )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    dDate := StoD( cDate )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TStr
@author Daniel Mendes de Melo Sousa
@since  27/06/2017
/*/
//-------------------------------------------------------------------
Method TStr() Class TAdvplTester
Local nLoop := 0
Local cStr  := ''

Self:SetFunctionName( 'Str' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
    cStr := Str( nLoop )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    cStr := Str( nLoop )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TStrZero
@author Daniel Mendes de Melo Sousa
@since  27/06/2017
/*/
//-------------------------------------------------------------------
Method TStrZero() Class TAdvplTester
Local nLoop := 0
Local nVal  := 0
Local nSize := 0
Local cStZr := ''

nVal  := 9876543
nSize := 10

Self:SetFunctionName( 'StrZero' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
     cStZr := StrZero( nVal , nSize )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    cStZr := StrZero( nVal , nSize )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TVal
@author Daniel Mendes de Melo Sousa
@since  27/06/2017
/*/
//-------------------------------------------------------------------
Method TVal() Class TAdvplTester
Local nLoop := 0
Local nVal  := 0
Local cVal  := ''

cVal := '0123456789'

Self:SetFunctionName( 'Val' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
     nVal := Val( cVal )
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    nVal := Val( cVal )
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil

//--------------------------------------------------Classe--------------------------------------------------//

//-------------------------------------------------------------------
/*/{Protheus.doc} xFnc
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Static Function xFnc( xParam )
Local xVariable := Nil
Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TTesteAdvpl
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Class TTesteAdvpl From LongNameClass
Method New()
Method Teste()
EndClass

//-------------------------------------------------------------------
/*/{Protheus.doc} New
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method New() Class TTesteAdvpl
Return Self

//-------------------------------------------------------------------
/*/{Protheus.doc} Teste
@author Daniel Mendes de Melo Sousa
@since  26/06/2017
/*/
//-------------------------------------------------------------------
Method Teste() Class TTesteAdvpl
Return Nil

/*
-- Protótipo do método
*/
//-------------------------------------------------------------------
/*/{Protheus.doc} Funcao
@author Daniel Mendes de Melo Sousa
@since  28/06/2017
/*/
//-------------------------------------------------------------------
/*
Method Funcao() Class TAdvplTester
Local nLoop := 0

Self:SetFunctionName( 'Funcao' )
Self:UpdateTime( 'For' , 'Begin' )

For nLoop := 1 To Self:nHowManyTimes
Next

Self:UpdateTime( 'For' , 'End' )

nLoop := 1

Self:UpdateTime( 'While' , 'Begin' )

While nLoop <= Self:nHowManyTimes
    nLoop++
EndDo

Self:UpdateTime( 'While' , 'End' )

Return Nil
*/