﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ComplaintVisitQuick.aspx.cs" Inherits="StarsProject.ComplaintVisitQuick" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="apple-touch-icon" href="app-assets/images/favicon/apple-touch-icon-152x152.png" />
    <link rel="shortcut icon" type="image/x-icon" href="app-assets/images/favicon/favicon-32x32.png" />
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="app-assets/vendors/vendors.min.css" />
    <link rel="stylesheet" type="text/css" href="app-assets/vendors/flag-icon/css/flag-icon.min.css" />
    <link rel="stylesheet" type="text/css" href="app-assets/css/pages/form-select2.min.css" />
    <link rel="stylesheet" type="text/css" href="app-assets/css/themes/vertical-modern-menu-template/materialize.css" />
    <link rel="stylesheet" type="text/css" href="app-assets/css/themes/vertical-modern-menu-template/style.css" />
    <link rel="stylesheet" type="text/css" href="app-assets/css/custom/custom.css" />

    <script type="text/javascript" src='<%=ResolveUrl("js/plugins/jquery-1.7.min.js") %>'></script>
    <script type="text/javascript" src="app-assets/js/vendors.min.js"></script>
    <script type="text/javascript" src="plugins/daterangepicker/moment.js"></script>
    <link rel="stylesheet" href="app-assets/vendors/select2/select2.min.css" type="text/css" />
    <link rel="stylesheet" href="app-assets/vendors/select2/select2-materialize.css" type="text/css" />

    <link href="css/jquery.auto-complete.css" rel="stylesheet" />
    <script type="text/javascript" src="js/jquery.auto-complete.min.js"></script>
    <script type="text/javascript" src="js/dataValidation.js"></script>
    <script type="text/javascript" src="js/myGeneric.js"></script>

    <style type="text/css">
        .clDiv70 {
            height: 50px;
            vertical-align: middle;
        }

        .imgChart {
            vertical-align: middle;
            Height: 40px;
            width: 40px;
        }

        #drpSelectDepartment {
            margin: 7px 0px;
            font-family: Verdana,Arial;
            font-size: 12px;
            vertical-align: middle;
        }

        .clTrans {
            background-color: transparent;
        }

        .ui-widget-header, .ui-state-default, ui-button {
            background: #b9cd6d;
            border: 1px solid #b9cd6d;
            color: #FFFFFF;
            font-weight: bold;
        }

        /* ==================================== */
        /*****         Modal Popup        *****/
        /* ==================================== */
        .Popup {
            background-color: #FFFFFF;
            border-width: 3px;
            border-style: solid;
            border-color: black;
            padding-top: 10px;
            padding-left: 10px;
            width: 96%;
            height: 96%;
        }

        .btnTopRightCorner {
            display: block;
            box-sizing: border-box;
            width: 30px;
            height: 30px;
            border-width: 3px;
            border-style: solid;
            border-color: red;
            border-radius: 100%;
            background: -webkit-linear-gradient(-45deg, transparent 0%, transparent 46%, white 46%, white 56%,transparent 56%, transparent 100%), -webkit-linear-gradient(45deg, transparent 0%, transparent 46%, white 46%, white 56%,transparent 56%, transparent 100%);
            background-color: red;
            box-shadow: 0px 0px 5px 2px rgba(0,0,0,0.5);
            transition: all 0.3s ease;
            position: relative;
            top: 12px;
            right: 15px;
        }
    </style>

    <script type="text/javascript">

        $(document).ready(function () {
            $('.datepicker').datepicker({ format: "dd-mm-yyyy" });
            $('.timepicker').timepicker();
            hideDivVisitType();
        });

        function hideDivVisitType() {
            if ($("#drpVisitType").val() == 'Charged')
                $("#dvVisitCharge").show();
            else
                $("#dvVisitCharge").hide();
        };

        function showcaseError(xMsg) {
            M.toast({ html: '<ul id="ulToast" style="list-style:circle;">' + xMsg + '</ul>', displayLength: 4000 });
        }
        function showcaseError(xMsg, xClass) {
            M.toast({ html: '<ul id="ulToast">' + xMsg + '</ul>', classes: xClass, displayLength: 4000 });
        }

        function closeSetTime() {
            $('div.divSetTime').hide();
            $('#hdnParent').val('');

        }
        function clearInputTime() {
            var fld = "#" + $('#hdnParent').val();
            $(fld).val('');
            $('#hdnParent').val('');
        }
        function setInputTime() {
            var h1, m1, ap;
            h1 = $('#ddlHrs').val();
            m1 = $('#ddlMins').val();
            ap = document.querySelector('input[name = "radioGrp"]:checked').value;
            // ----------------------------------
            var fld = "#" + $('#hdnParent').val();
            $(fld).val(h1 + ":" + m1 + " " + ap);
            if (parseInt(h1) >= 10 && parseInt(m1) > 15)
                $(fld).css({ color: "red" });
            else
                $(fld).css({ color: "black" });

            $('div.divSetTime').hide();
            $('#hdnParent').val('');
        }
        function popupSetTime(ctrlfld) {
            var fld = ctrlfld.id;
            $('#hdnParent').val(ctrlfld.id);
            var pos = $(ctrlfld).position();
            var width = $(ctrlfld).outerWidth();
            var leftVal = ($('#hdnParent').val() == "txtTimeFrom") ? "-100px" : "120px";
            $('div.divSetTime').css({ position: "absolute", zIndex: 5010, top: "200px", left: leftVal }).show();
            // -------------------------------------------------------------------------
            if ($("#hdnParent").val().toLocaleLowerCase().indexOf("idate") != -1) {
                $('#ddlHrs').val("10");
                $('#ddlMins').val("00");
                $('input:radio[name=radioGrp][value=AM]').click();
            }
            else {
                $('#ddlHrs').val("07");
                $('#ddlMins').val("00");
                $('input:radio[name=radioGrp][value=PM]').click();
            }
        }

        function openCustomerInfo(cat) {
            var keyid = (cat == 'view') ? jQuery('#hdnCustomerID').val() : "0";
            var pageUrl = (cat == 'view') ? "customers.aspx?mode=view&id=" + keyid : "customers.aspx?mode=view&id=0";
            $('#ifrModule').attr('src', pageUrl);
            $find("mpe").show();
        }
        /*---------------------------------------------------------*/
        function showErrorPopup(xTitle, xMsg) {
            if (xTitle == '')
                xTitle = 'Message';
            // -------------------------------------
            if (xMsg != '') {
                jQuery.confirm({
                    title: xTitle, content: xMsg, type: 'red', typeAnimated: true, width: 'auto',
                    buttons: { close: { text: 'Close', btnClass: 'btn-blue ConfirmClose', action: function () { } } }
                });
            }
        }
        function ShowPDFfile(repFilename) {
            repFilename = "DocumentGallery/" + repFilename;
            yhooWin = window.open(repFilename, "ywin", "width=1050,height=750");
            yhooWin.focus();
        }
    </script>
</head>
<body class="loginpage">
    <form id="frmEntry" runat="server" autocomplete="off">

        <asp:ScriptManager ID="srcUser" runat="server"></asp:ScriptManager>

        <div id="contentwrapper" class="contentwrapper">

            <%--<asp:UpdatePanel ID="upUserPanel" runat="server" UpdateMode="Always">
            <ContentTemplate>--%>
            <div class="widgetbox">
                <div class="clearall"></div>
                <asp:HiddenField ID="hdnParent" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="hdnpkID" runat="server" ClientIDMode="Static" Value="0" />
                <asp:HiddenField ID="hdnComplaintNo" runat="server" ClientIDMode="Static" Value="0" />
                <asp:HiddenField ID="hdnCustomerID" runat="server" ClientIDMode="Static" Value="0" />
                <asp:HiddenField ID="hdnEmployeeID" runat="server" ClientIDMode="Static" Value="0" />

                <div id="myModal" style="display: block; width: 100%;">
                    <div class="modal-content">
                        <div class="modal-body">
                            <div class="row">
                                <div class="input-field col m7">
                                    <div class="input-field col m12">
                                        <div class="input-field col m8">
                                            <label class="active" for="txtCustomerName">
                                                Customer Name  <span class="materialize-red-text font-weight-800">*</span>
                                                <a href="javascript:openCustomerInfo('view');">
                                                    <img src="images/registration.png" width="30" height="20" alt="Preview Customer Info" title="Preview Customer Info" style="display: inline-block; padding: 6px 0px 0px 0px" TabIndex="1" />
                                                </a>
                                               <a href="javascript:openCustomerInfo('add');">
                                                    <img src="images/addCustomer.png" width="30" height="20" style="padding: 6px 0px 0px 0px" alt="Add New Customer" title="Add New Customer" />
                                               </a>
                                            </label>
                                            <asp:TextBox ID="txtCustomerName" runat="server" ClientIDMode="Static" class="form-control" TabIndex="1" AutoPostBack="true" onKeyup="bindDDLTo('#txtCustomerName')" OnTextChanged="txtCustomerName_TextChanged" placeholder="Min.3 Chars To Search" />
                                        </div>
                                        <div class="input-field col m4">
                                            <label class="active" for="drpComplaintNo">Complaint # <span class="materialize-red-text font-weight-800">*</span></label>
                                            <asp:DropDownList ID="drpComplaintNo" runat="server" class="select2-theme browser-default" AutoPostBack="true" OnSelectedIndexChanged="drpComplaintNo_SelectedIndexChanged" ClientIDMode="Static" TabIndex="2"></asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="input-field col m12">
                                        <label class="active" for="txtAddress">Address </label>
                                        <asp:TextBox ID="txtAddress" Enabled="false" runat="server" class="form-control" placeholder="" onkeypress="return false;" onpaste="return false" ClientIDMode="Static" TabIndex="4" />
                                    </div>
                                    <div class="input-field col m12">
                                        <div class="input-field col m2">
                                            <label class="active" for="drpStatus">Status</label>
                                            <asp:DropDownList ID="drpStatus" runat="server" class="select2-theme browser-default" ClientIDMode="Static" TabIndex="3">
                                                <asp:ListItem Text="Open" Value="Open"  />
                                                <asp:ListItem Text="Close" Value="Close" Selected="True" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="input-field col m3">
                                            <label class="active" for="txtVisitDate">Attended On <span class="materialize-red-text font-weight-800">*</span></label>
                                            <asp:TextBox ID="txtVisitDate" runat="server" class="form-control" placeholder="" onkeypress="return false;" onpaste="return false" ClientIDMode="Static" TabIndex="4"  TextMode="Date"/>
                                        </div>
                                        <div class="input-field col m5 hide">
                                            <label class="active" for="txtTimeFrom">Visit Timing </label>
                                            <asp:TextBox ID="txtTimeFrom" runat="server" class="timepicker" ClientIDMode="Static" TabIndex="5" placeholder="" onkeypress="return false;" onpaste="return false" Style="width: 100px; display: inline-block;" ReadOnly="false" />&nbsp;&nbsp;
                                            <asp:TextBox ID="txtTimeTo" runat="server" class="timepicker" ClientIDMode="Static" TabIndex="5" placeholder="" onkeypress="return false;" onpaste="return false" Style="width: 100px; display: inline-block;" ReadOnly="false" />
                                        </div>
                                        <div class="input-field col m2">
                                            <label class="active" for="drpVisitType">Visit Type</label>
                                            <asp:DropDownList ID="drpVisitType" runat="server" class="select2-theme browser-default" ClientIDMode="Static" AutoPostBack="true" TabIndex="6">
                                                <asp:ListItem Text="Free" Value="Free" Selected="True" />
                                                <asp:ListItem Text="Charged" Value="Charged" />
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="input-field col m5">
                                    <div id="documents" class="row" runat="server" clientidmode="Static" enableviewstate="true">
                                        <div class="row">
                                            <div class="app-file-area" style="height: 100px;">
                                                <div class="app-file-header">
                                                    <div class="row">
                                                        <div class="input-field col m12 add-new-file mt-0">
                                                            <div class="col m12">
                                                                <label class="active" for="uploadDocument">Upload Document ...</label>
                                                            </div>
                                                            <br />
                                                            <div class="col m12">
                                                                <asp:FileUpload ID="uploadDocument" runat="server" ClientIDMode="Static" CssClass="Cntrl1" onchange="this.form.submit()" ToolTip="Select Only BMP, JPEG, GIF, PNG And PDF File" />
                                                                <asp:Button ID="Button4" CssClass="hide" runat="server" Text="Upload" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="app-file-content">
                                                    <div id="divDocumentControl2 col m12">
                                                        <div class="col m3 center-align" style="padding: 10px; height: 150px; width: 150px; margin: 0px 0px 0px 20px; border-radius: 4px; border: 1px solid silver;">
                                                            <asp:Image ID="imgDocument" runat="server" ClientIDMode="Static" Width="100%" Height="100%" ImageUrl="images/attach_document.png" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                     </div>
                                </div>
                            </div>
                            <div class="row mt-1">
                                <div class="input-field col m12">
                                    <label class="active" for="txtVisitNotes">Visit Notes <span class="materialize-red-text font-weight-800">*</span></label>
                                    <asp:TextBox ID="txtVisitNotes" runat="server" class="form-control" ClientIDMode="Static" TabIndex="7" MaxLength="1000" TextMode="MultiLine" Rows="4" style="height:200px;" placeholder="" />
                                </div>
                            </div>
                            <div id="dvVisitCharge" runat="server" clientidmode="Static" class="row mt-2 badge-primary">
                                <div class="input-field col m2">
                                    <label class="active" for="drpVisitChargeType">Charge Type <span class="materialize-red-text font-weight-800">*</span></label>
                                    <asp:DropDownList ID="drpVisitChargeType" runat="server" class="select2-theme browser-default" ClientIDMode="Static" TabIndex="8">
                                        <asp:ListItem Text="-- Select --" Value="" Selected="True" />
                                        <asp:ListItem Text="Free" Value="Free" />
                                        <asp:ListItem Text="Cash" Value="Cash" />
                                        <asp:ListItem Text="Cheque" Value="Cheque" />
                                        <asp:ListItem Text="Paytm" Value="Paytm" />
                                        <asp:ListItem Text="PhonePe" Value="PhonePe" />
                                        <asp:ListItem Text="GooglePay" Value="GooglePay" />
                                        <asp:ListItem Text="Other" Value="Other" />
                                    </asp:DropDownList>
                                </div>
                                <div class="input-field col m2">
                                    <label class="active" for="txtVisitCharge">Visit Charge <span class="materialize-red-text font-weight-800">*</span></label>
                                    <asp:TextBox ID="txtVisitCharge" runat="server" MaxLength="15" class="form-control" ClientIDMode="Static" TabIndex="9" Style="width: 160px; display: inline-block;" placeholder="" />
                                </div>
                            </div>
                        </div>
                        <div class="row padding-1 gradient-45deg-blue-grey-blue-grey vertical-align-bottom" style="margin-top:10px;"">
                            <button id="btnReset" type="button" runat="server" clientidmode="Static" text="Reset" class="btn orange left" onserverclick="btnReset_Click" tabindex="10"><i class="material-icons left">backspace</i>Clear & Add New</button>
                            <button id="btnSave" type="button" runat="server" clientidmode="Static" text="Save" class="btn cyan right mr-1" onserverclick="btnSave_Click" tabindex="11"><i class="material-icons left">save</i>Save</button>
                        </div>
                        
                    </div>
                </div>
            </div>

            <%--**************************** Customer Popup ***********************************--%>
                <asp:Button ID="Button1" CssClass="hide" runat="server" Text="Fill Form in Popup" /> 
                <cc1:ModalPopupExtender ID="myModalPopup" BehaviorID="mpe" runat="server" ClientIDMode="Static" PopupControlID="Panl1" TargetControlID="Button1" CancelControlID="Button2" BackgroundCssClass="Background">  
                </cc1:ModalPopupExtender>  
                <asp:Panel ID="Panl1" runat="server" CssClass="Popup" align="center" style = "display:none; border-radius:10px; padding-right: 10px !important;">  
                    <div id="myModal1">
                        <div class="modal-header position-sticky gradient-45deg-light-blue-indigo m-0" style="margin-bottom:10px !important;">
                            <h5 class=" z-depth-5" style="font-size: 2rem !important; font-weight:800; line-height: 50px; margin: 0; text-align: left; padding-left: 15px;">
                                <i class="material-icons prefix">ac_unit</i>
                                <span id="spnModuleHeader" runat="server" clientidmode="static">Manage Module</span>
                                <asp:Button CssClass="btnTopRightCorner float-right" ID="Button2" runat="server" Text=""/>
                            </h5>
                        </div>
                    </div>
                    <iframe id="ifrModule" src="about:blank" runat="server" clientidmode="static" scrolling="auto" style="border:1px solid silver; background-color:transparent; width:100%; height:90%; padding:5px;"></iframe>  
                   <br/>  
                </asp:Panel> 

            <%-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* --%>

            <%--<div id="divSetTime" class="modal divSetTime" style="display:none; min-height:500px !important;">
                  <div class="modal-dialog" role="document" style="width:250px;">
                    <div class="modal-content" style="border:1px groove black; box-shadow: black -6px 8px 6px -6px; min-height:0;">
                      <div class="modal-header" style="padding:5px 10px;">
                        <h5 class="modal-title">Set Time</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="closeSetTime();" >
                          <span aria-hidden="true">&times;</span>
                        </button>
                      </div>
                      <div class="modal-body" style="padding:8px">
                            <div style="border-radius:5px; width:100%;">
                                <fieldset style="text-align:left;">
                                    <table cellpadding="1" cellspacing="0">
                                        <tr style="padding:8px 15px;">
                                            <td>
                                                <asp:DropDownList ID="ddlHrs" runat="server" ClientIDMode="Static">
                                                    <asp:ListItem Value="01" Text="01" />
                                                    <asp:ListItem Value="02" Text="02" />
                                                    <asp:ListItem Value="03" Text="03" />
                                                    <asp:ListItem Value="04" Text="04" />
                                                    <asp:ListItem Value="05" Text="05" />
                                                    <asp:ListItem Value="06" Text="06" />
                                                    <asp:ListItem Value="07" Text="07" />
                                                    <asp:ListItem Value="08" Text="08" />
                                                    <asp:ListItem Value="09" Text="09" />
                                                    <asp:ListItem Value="10" Text="10" />
                                                    <asp:ListItem Value="11" Text="11" />
                                                    <asp:ListItem Value="12" Text="12" />
                                                </asp:DropDownList>
                                                &nbsp;:
                                                <asp:DropDownList ID="ddlMins" runat="server" ClientIDMode="Static">
                                                    <asp:ListItem Value="00" Text="00" />
                                                    <asp:ListItem Value="15" Text="15" />
                                                    <asp:ListItem Value="30" Text="30" />
                                                    <asp:ListItem Value="45" Text="45" />
                                                    <asp:ListItem Value="--" Text="--" />
                                                    <asp:ListItem Value="00" Text="00" />
                                                    <asp:ListItem Value="00" Text="00" />
                                                    <asp:ListItem Value="01" Text="01" />
                                                    <asp:ListItem Value="02" Text="02" />
                                                    <asp:ListItem Value="03" Text="03" />
                                                    <asp:ListItem Value="04" Text="04" />
                                                    <asp:ListItem Value="05" Text="05" />
                                                    <asp:ListItem Value="06" Text="06" />
                                                    <asp:ListItem Value="07" Text="07" />
                                                    <asp:ListItem Value="08" Text="08" />
                                                    <asp:ListItem Value="09" Text="09" />
                                                    <asp:ListItem Value="10" Text="10" />
                                                    <asp:ListItem Value="11" Text="11" />
                                                    <asp:ListItem Value="12" Text="12" />
                                                    <asp:ListItem Value="13" Text="13" />
                                                    <asp:ListItem Value="14" Text="14" />
                                                    <asp:ListItem Value="15" Text="15" />
                                                    <asp:ListItem Value="16" Text="16" />
                                                    <asp:ListItem Value="17" Text="17" />
                                                    <asp:ListItem Value="18" Text="18" />
                                                    <asp:ListItem Value="19" Text="19" />
                                                    <asp:ListItem Value="20" Text="20" />
                                                    <asp:ListItem Value="21" Text="21" />
                                                    <asp:ListItem Value="22" Text="22" />
                                                    <asp:ListItem Value="23" Text="23" />
                                                    <asp:ListItem Value="24" Text="24" />
                                                    <asp:ListItem Value="25" Text="25" />
                                                    <asp:ListItem Value="26" Text="26" />
                                                    <asp:ListItem Value="27" Text="27" />
                                                    <asp:ListItem Value="28" Text="28" />
                                                    <asp:ListItem Value="29" Text="29" />
                                                    <asp:ListItem Value="30" Text="30" />
                                                    <asp:ListItem Value="31" Text="31" />
                                                    <asp:ListItem Value="32" Text="32" />
                                                    <asp:ListItem Value="33" Text="33" />
                                                    <asp:ListItem Value="34" Text="34" />
                                                    <asp:ListItem Value="35" Text="35" />
                                                    <asp:ListItem Value="36" Text="36" />
                                                    <asp:ListItem Value="37" Text="37" />
                                                    <asp:ListItem Value="38" Text="38" />
                                                    <asp:ListItem Value="39" Text="39" />
                                                    <asp:ListItem Value="40" Text="40" />
                                                    <asp:ListItem Value="41" Text="41" />
                                                    <asp:ListItem Value="42" Text="42" />
                                                    <asp:ListItem Value="43" Text="43" />
                                                    <asp:ListItem Value="44" Text="44" />
                                                    <asp:ListItem Value="45" Text="45" />
                                                    <asp:ListItem Value="46" Text="46" />
                                                    <asp:ListItem Value="47" Text="47" />
                                                    <asp:ListItem Value="48" Text="48" />
                                                    <asp:ListItem Value="49" Text="49" />
                                                    <asp:ListItem Value="50" Text="50" />
                                                    <asp:ListItem Value="51" Text="51" />
                                                    <asp:ListItem Value="52" Text="52" />
                                                    <asp:ListItem Value="53" Text="53" />
                                                    <asp:ListItem Value="54" Text="54" />
                                                    <asp:ListItem Value="55" Text="55" />
                                                    <asp:ListItem Value="56" Text="56" />
                                                    <asp:ListItem Value="57" Text="57" />
                                                    <asp:ListItem Value="58" Text="58" />
                                                    <asp:ListItem Value="59" Text="59" />
                                                </asp:DropDownList>
                                                &nbsp;&nbsp;
                                                <input type="radio" name="radioGrp" value="AM" checked="checked"/>AM&nbsp;&nbsp;
                                                <input type="radio" name="radioGrp" value="PM"/>PM&nbsp;&nbsp;&nbsp;&nbsp;
                                            </td>
                                        </tr>
                                        <tr style="text-align:center;">
                                            <td style="text-align: center; padding:8px;">
                                                <input class="center btn-primary" type="button" id="btnSetTime" name="btnSetTime" value="Set Time" style="padding: 2px 8px;border-radius: 5px;" onclick="setInputTime();" />&nbsp;&nbsp;&nbsp;
                                                <input class="center btn-dark" type="button" id="btnClearTime" name="btnClearTime" value="Clear Time" style="padding: 2px 8px;border-radius: 5px;" onclick="clearInputTime();" />&nbsp;&nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </div>
                      </div>
                    </div>
                  </div>
                </div>--%>

            <script type="text/javascript">
                function bindDDLTo(selector) {
                    if ($(selector).val().length >= 1) {
                        jQuery.ajax({
                            type: "POST",
                            url: "InquiryInfo.aspx/FilterCustomer",
                            data: '{pCustName:\'' + $(selector).val() + '\'}',
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                //console.log(data);
                                //var resultdata = JSON.parse(data.d);
                                var sample = JSON.parse(data.d);
                                $(selector).autoComplete({
                                    minChars: 1,
                                    source: function (term, suggest) {
                                        term = term.toLowerCase();
                                        var choices = sample;
                                        suggest(choices);
                                    },
                                    renderItem: function (item, search) {
                                        $(".autocomplete-suggestion").remove();
                                        return '<div class="autocomplete-suggestion" style="position:relative !important;" data-langname="' + item.CustomerID + '" data-lang="' + item.CustomerName + '" data-val="' + search + '">' + item.CustomerName + '</div>';
                                    },
                                    onSelect: function (e, term, item) {
                                        //console.log('Item "' + item.data('langname') + ' (' + item.data('lang') + ')" selected by ' + (e.type == 'keydown' ? 'pressing enter or tab' : 'mouse click') + '.');
                                        $(selector).val(item.html());
                                        $("#hdnCustomerID").val(item.data('langname'));
                                        $("#drpInquiry").focus();
                                    }
                                });

                            },
                            error: function (r) { alert('Error : ' + r.responseText); },
                            failure: function (r) { alert('failure'); }
                        });
                        return false;
                    }
                    else {
                        if ($(selector).val().length == 0) {
                            $("#hdnCustomerID").val('');


                        }
                    }
                }
            </script>
            <%--</ContentTemplate>
        </asp:UpdatePanel>--%>
        </div>
        <%-- *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* --%>
    </form>
</body>
</html>
