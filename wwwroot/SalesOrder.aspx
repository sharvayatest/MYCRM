﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SalesOrder.aspx.cs" Inherits="StarsProject.SalesOrder" MaintainScrollPositionOnPostback="true" %>
<%@ Register Src="~/myModuleAttachment.ascx" TagPrefix="uc1" TagName="myModuleAttachment" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="app-assets/vendors/vendors.min.css" />
    <link rel="stylesheet" type="text/css" href="app-assets/css/themes/vertical-modern-menu-template/materialize.css" />
    <link rel="stylesheet" type="text/css" href="app-assets/css/themes/vertical-modern-menu-template/style.css" />

    <script type="text/javascript" src='<%=ResolveUrl("js/plugins/jquery-1.7.min.js") %>'></script>
    <script type="text/javascript" src="app-assets/js/vendors.min.js"></script>
    <script type="text/javascript" src="plugins/daterangepicker/moment.js"></script>

    <link rel="stylesheet" href="app-assets/vendors/select2/select2.min.css" type="text/css" />
    <link rel="stylesheet" href="app-assets/vendors/select2/select2-materialize.css" type="text/css" />
    <script src="app-assets/vendors/select2/select2.full.min.js"></script>
    <%--    <script src="app-assets/js/scripts/form-select2.js"></script>--%>

    <link href="css/jquery.auto-complete.css" rel="stylesheet" />
    <script type="text/javascript" src="js/jquery.auto-complete.min.js"></script>

    <style type="text/css">
        table.responsive-table.striped.width-100 th {
            background-color: #6868d6 !important;
            color: white !important;
        }
        /* ==================================== */
        /*             The ribbons              */
        /* ==================================== */
        .corner-ribbon {
          width: 250px;
          background: #e43;
          position: absolute;
          top: 10px;
          left: -90px;
          text-align: center;
          line-height: 50px;
          letter-spacing: 1px;
          color: #f0f0f0;
          transform: rotate(-45deg);
          -webkit-transform: rotate(-45deg);
          overflow: hidden;
        }
        .corner-ribbon.shadow {
          box-shadow: 0 0 3px rgba(0, 0, 0, .3);
        }
        /* Different positions */

        .corner-ribbon.top-right {
          /* top: 18px; */
            top:30px;
          right: -70px;
          left: auto;
          transform: rotate(45deg);
          -webkit-transform: rotate(46deg);
          overflow: hidden;
        }
        .corner-ribbon.blue {
          background: #39d;
        }
        .corner-ribbon.green {
          background: green;
        }
        .corner-ribbon.red {
          background: green;
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
        /* ==================================== */
        /***** 19. STANDARD TABLES STYLES *****/
        /* ==================================== */
        .table input:not([type]), input[type=text]:not(.browser-default), input[type=password]:not(.browser-default),
        input[type=email]:not(.browser-default), input[type=url]:not(.browser-default), input[type=time]:not(.browser-default),
        input[type=date]:not(.browser-default), input[type=datetime]:not(.browser-default), input[type=datetime-local]:not(.browser-default),
        input[type=tel]:not(.browser-default), input[type=number]:not(.browser-default), input[type=search]:not(.browser-default), textarea.materialize-textarea {
            margin: 0px !important;
            height: 1.5rem !important;
            border-radius: 3px !important;
            font-size: 13px !important;
        }

        #tblQuotationDetail > tbody > tr > td {
            padding-top: 0px !important;
            padding-bottom: 0px !important;
        }

        #tblCharge > tbody > tr > td {
            padding-top: 0px !important;
            padding-bottom: 0px !important;
        }

        #tblSummary > tbody > tr > td {
            padding-top: 0px !important;
            padding-bottom: 0px !important;
        }

        .limited {
            white-space: nowrap;
            max-width: 300px;
            overflow: hidden;
            text-overflow: ellipsis;
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            
        });

        function pageLoad(sender, args) {
            $('tabs').tabs();
            $('.datepicker').datepicker({
                defaultDate: new Date((new Date()).getFullYear(), (new Date()).getMonth(), (new Date()).getDay()),
                format: "dd-mm-yyyy"
            });
            $('.timepicker').timepicker();
            $(".inputOther input:text").focus(function () { $(this).select(); });
            $(".inputOther input:text").click(function () { $(this).select(); });
            $('#menuDiscovery').click(function () { $('.tap-target').tapTarget('open'); });
            $('.select2-size-sm').select2({
                dropdownAutoWidth: true,
                width: '100%',
                containerCssClass: 'select-sm'
            });
            $('#txtOrderNo').focus();
            // --------------------------------------------------------
            $(function () {
                $(".tabs a").click(function () {
                    $("#hdnCurrTab").val($(this).attr("href").replace("#", ""));
                    retainTabPosition();
                });
            });

            setHiddenControls();
        }
        function retainTabPosition() {

            var currTab = $("#hdnCurrTab").val();

            $("#lnkProducts").removeClass("active");
            $("#lnkEmail").removeClass("active");
            $("#lnkTNC").removeClass("active");
            $("#lnkPaySch").removeClass("active");
            $("#lnkShipment").removeClass("active");
            $("#lnkProduction").removeClass("active");
            $("#lnkAttachment").removeClass("active");
            $("#lnkshipmentaddress").removeClass("active");

            $("#pnl_Products").css("display", "none");
            $("#pnl_TNC").css("display", "none");
            $("#pnl_Email").css("display", "none");
            $("#pnl_PaySch").css("display", "none");
            $("#pnl_Shipment").css("display", "none");
            $("#pnl_Production").css("display", "none");
            $("#pnl_Attachment").css("display", "none");
            $("#pnl_ShipmentAddress").css("display", "none");

            if (currTab == 'pnl_Products') {
                $("#lnkProducts").addClass("active");
                $("#pnl_Products").css("display", "block");
            }
            else if (currTab == 'pnl_Email') {
                $("#lnkEmail").addClass("active");
                $("#pnl_Email").css("display", "block");
            }
            else if (currTab == 'pnl_TNC') {
                $("#lnkTNC").addClass("active");
                $("#pnl_TNC").css("display", "block");
            }
            else if (currTab == 'pnl_PaySch') {
                $("#lnkPaySch").addClass("active");
                $("#pnl_PaySch").css("display", "block");
            }
            else if (currTab == 'pnl_Shipment') {
                $("#lnkShipment").addClass("active");
                $("#pnl_Shipment").css("display", "block");
            }
            else if (currTab == 'pnl_Production') {
                $("#lnkProduction").addClass("active");
                $("#pnl_Production").css("display", "block");
            }
            else if (currTab == 'pnl_Attachment') {
                $("#lnkAttachment").addClass("active");
                $("#pnl_Attachment").css("display", "block");
            }
            else if (currTab == 'pnl_ShipmentAddress') {
                $("#lnkshipmentaddress").addClass("active");
                $("#pnl_ShipmentAddress").css("display", "block");
            }


        }
        /*---------------------------------------------------------*/
        function showcaseError(xMsg) {
            M.toast({ html: '<ul id="ulToast" style="list-style:circle;">' + xMsg + '</ul>', displayLength: 4000 });
        }
        function showcaseError(xMsg, xClass) {
            M.toast({ html: '<ul id="ulToast">' + xMsg + '</ul>', classes: xClass, displayLength: 4000 });
        }
        function showcaseMessage(xText, xIcon) {
            xText = (xText == '') ? 'Action Performed !' : xText;
            xIcon = (xIcon == '') ? 'Info' : xIcon;
            swal({ title: "Message", text: xText, icon: xIcon });
        }

        function showErrorMessage(strMess) {
            jQuery.confirm({ title: 'Data Validation', content: 'Are you sure, You want to delete record !', type: 'red', typeAnimated: true });
        }
        /*---------------------------------------------------------*/
        function calcQuotation() {
            var q = parseFloat(jQuery("#txtQuantity").val() != '' ? jQuery("#txtQuantity").val() : 0);
            var ur = parseFloat(jQuery("#txtUnitRate").val() != '' ? jQuery("#txtUnitRate").val() : 0);
            var dp = parseFloat(jQuery("#txtDiscountPercent").val() != '' ? jQuery("#txtDiscountPercent").val() : 0);

            var nr = (ur - ((ur * dp) / 100)).toFixed(2);
            jQuery("#txtNetRate").val(nr);

            var a = (q * nr).toFixed(2);
            jQuery("#txtAmount").val(a);

            var tr = parseFloat(jQuery("#txtTaxRate").val() != '' ? jQuery("#txtTaxRate").val() : 0);
            ta = ((a * tr) / 100).toFixed(2);
            jQuery("#txtTaxAmount").val(ta);

            na = (parseFloat(a) + parseFloat(ta)).toFixed(2);
            jQuery("#txtNetAmount").val(na);
        }

        function openCustomerInfo(cat) {
            document.getElementById('spnModuleHeader').innerText = "Customer Information";
            var keyid = (cat == 'view') ? jQuery('#hdnCustomerID').val() : "0";
            var pageUrl = (cat == 'view') ? "customers.aspx?mode=view&id=" + keyid : "customers.aspx?mode=view&id=0";
            $('#ifrModule').attr('src', pageUrl);
            $find("mpe").show();
        }

        /*Add Product view on Product Name Vikram Rajput 15-07-2020*/
        function openProductInfo(cat) {
            document.getElementById('spnModuleHeader').innerText = "Product Information";
            var keyid = "0";
            var pageUrl = "Products.aspx?mode=view&id=0";
            $('#ifrModule').attr('src', pageUrl);
            $find("mpe").show();
        }
        function gridAction(mode, id) {
            document.getElementById('spnModuleHeader').innerText = "General Template Information";
            var pageUrl = '';
            debugger;
            var id = jQuery("#drpEmailCategory").val();
            pageTitle = "Manage General Template";
            pageUrl = "GeneralTemplate.aspx?mode=" + mode + "&id=" + (id != '' && id != null ? id : 0);
            $('#ifrModule').attr('src', pageUrl);
            $find("mpe").show();
        }
        function openSpecification(pProdID) {
            document.getElementById('spnModuleHeader').innerText = "Product Specification";
            var t11, t22;
            t11 = jQuery("#txtOrderNo").val();
            //if ($('input[type="radio"]:checked').val() == "Quotation")
            if ($('#rdblOption').val() == "Quotation")
                t22 = jQuery("#drpReferenceNo").val();
            else
                t22 = "";
            var pageUrl = "SalesOrderSpecification.aspx?OrderNo=" + t11 + "&FinishProductID=" + pProdID + "&QuotationNo=" + t22;
            $('#ifrModule').attr('src', pageUrl);
            $find("mpe").show();
            //$.colorbox({
            //    width: "98%", height: "98%", rel: 'cbQtSpec', inline: true, iframe: true, href: "SalesOrderSpecification.aspx?OrderNo=" + t11 + "&FinishProductID=" + pProdID + "&QuotationNo=" + t22,
            //    onClosed: function () { }
            //});
        }
        //function getSelectedOrders() {
        //    var test = $(".select2-selection__rendered").find('li.select2-selection__choice').text().substring(1).replace("×", ",");
        //    $("#hdnSelectedReference").val(test.replace("×", ","));
        //}

        function getSelectedOrders() {
            var test = $(".select2-selection__rendered").find('li.select2-selection__choice').text();
            var myArr = test.substring(1).split("×");
            $("#hdnSelectedReference").val(myArr.join());
        }

        function openAssembly(pProdID) {
            document.getElementById('spnModuleHeader').innerText = "Product Assembly Information";
            var t11;
            t11 = jQuery("#txtOrderNo").val();
            var pageUrl = "SalesOrderAssembly.aspx?OrderNo=" + t11 + "&FinishProductID=" + pProdID;
            $('#ifrModule').attr('src', pageUrl);
            $find("mpe").show();
        }

        function setHiddenControls() {
            var userData = JSON.stringify({ "pPageName": 'salesorder' });
            $.ajax({
                type: "POST",
                url: "/Services/NagrikService.asmx/GetPageHiddenControls",
                data: userData,
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (data) {
                    $("#hdnHiddenControl").val(data.d);
                    //alert($("#hdnHiddenControl").val())
                    // ---------------------------------------------------------------
                    $('#frmSalesOrder *').filter(':input').each(function () {
                        var idName = $(this).attr('id') + ',';
                        if ($("#hdnHiddenControl").val().indexOf(idName) >= 0) {
                            $(this).parent().hide();
                        }
                    });
                },
                failure: function (errMsg) { alert(errMsg); }
            });
        }
    </script>

</head>
<body class="loginpage">
    <form id="frmSalesOrder" runat="server">
        <asp:ScriptManager ID="srcUser" runat="server"></asp:ScriptManager>
        <div id="contentwrapper" class="contentwrapper">
            <asp:UpdatePanel ID="upUserPanel" runat="server" UpdateMode="Conditional" EnableViewState="true">
                <ContentTemplate>
                    <div class="widgetbox">
                        <div id="divApprovalStatus" runat="server" class="corner-ribbon top-right sticky blue shadow" visible="false"></div>
                        <%-- Bootstrap Quotation Modal Popup --%>
                        <div class="clearall"></div>
                        <asp:HiddenField ID="hdnCustWisePro" runat="server" ClientIDMode="Static" />
                        <asp:HiddenField ID="hdnpkID" runat="server" ClientIDMode="Static" />
                        <asp:HiddenField ID="hdnSerialKey" runat="server" ClientIDMode="Static" />
                        <asp:HiddenField ID="hdnProductUnitQty" runat="server" ClientIDMode="Static" />
                        <asp:HiddenField ID="hdnCustomerID" runat="server" ClientIDMode="Static" />
                        <asp:HiddenField ID="hdnMode" runat="server" ClientIDMode="Static" />
                        <asp:HiddenField ID="hdnQuotationSpecification" runat="server" ClientIDMode="Static" />
                        <asp:HiddenField ID="hdnQuotationCurrency" runat="server" ClientIDMode="Static" Value="No" />
                        <asp:HiddenField ID="hdnCurrTab" runat="server" ClientIDMode="Static" EnableViewState="true" Value="pnl_Products" />
                        <asp:HiddenField ID="hdnApplicationIndustry" runat="server" ClientIDMode="Static" Value="" />
                        <asp:HiddenField ID="hdnSelectedReference" runat="server" ClientIDMode="Static" />

                        <asp:HiddenField ID="hdnHiddenControl" runat="server" ClientIDMode="Static" Value="" />
                        <div id="myModal" style="display: block; width: 100%;">
                            <div class="modal-content">
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col m12">
                                            <div class="row">
                                                <div class="input-field col m2">
                                                    <label class="active" for="txtOrderNo">Order #</label>
                                                    <asp:TextBox ID="txtOrderNo" runat="server" class="form-control" ClientIDMode="Static" TabIndex="1" ReadOnly="true" placeholder="" />
                                                </div>
                                                <div class="input-field col m2">
                                                    <label class="active" for="txtOrderDate">Order Date <span class="materialize-red-text font-weight-800">*</span></label>
                                                    <asp:TextBox ID="txtOrderDate" runat="server" class="form-control" ClientIDMode="Static" TabIndex="2" placeholder="" TextMode="Date" />
                                                </div>
                                                <div class="input-field col m3">
                                                    <asp:HiddenField ID="hdnCustStateID" runat="server" ClientIDMode="Static" />
                                                    <label class="active" for="txtCustomerName">
                                                        Customer Name 
                                                        <span class="materialize-red-text font-weight-800">*</span>
                                                        <a href="javascript:openCustomerInfo('view');">
                                                            <img src="images/registration.png" width="20" height="20" alt="Preview Customer Info" title="Preview Customer Info" style="display: inline-block; padding: 6px 0px 0px 0px;" />
                                                        </a>
                                                        <a href="javascript:openCustomerInfo('add');">
                                                            <img src="images/addCustomer.png" width="20" height="20" alt="Add New Customer" title="Add New Customer" style="display: inline-block; padding: 6px 0px 0px 0px;" />
                                                        </a>
                                                    </label>
                                                    <asp:TextBox ID="txtCustomerName" runat="server" ClientIDMode="Static" class="form-control" onKeyup="bindDDLTo('#txtCustomerName')" AutoPostBack="true" OnTextChanged="txtCustomerName_TextChanged" TabIndex="3" placeholder="Min.3 Char.To Search" MaxLength="50" />
                                                </div>
                                                <div class="input-field col m2">
                                                    <label class="active" for="drpBank">Select Bank Details </label>
                                                    <asp:DropDownList ID="drpBank" runat="server" class="select2-theme browser-default" placeholder="" EnableViewState="true" ClientIDMode="Static" TabIndex="4" />
                                                </div>
                                                <div class="input-field col m1.5">
                                                    <label class="active" for="txtPINo">PI No.</label>
                                                    <asp:TextBox ID="txtPINo" runat="server" class="form-control" ClientIDMode="Static" TabIndex="5" placeholder="" />
                                                </div>
                                                <div class="input-field col m1.5">
                                                    <label class="active" for="txtPIDate">PI Date </label>
                                                    <asp:TextBox ID="txtPIDate" runat="server" class="form-control" ClientIDMode="Static" TabIndex="6" placeholder="" TextMode="Date" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div id="divLoad0" runat="server" clientidmode="Static" class="input-field col m1.5">
                                                    <label class="active" for="rdblOption">Select Option</label>
                                                    <asp:DropDownList ID="rdblOption" runat="server" class="select2-theme browser-default" EnableViewState="true" ClientIDMode="Static" AutoPostBack="true" OnSelectedIndexChanged="rdblOption_SelectedIndexChanged" TabIndex="5">
                                                        <asp:ListItem Text="Inquiry" Value="Inquiry" />
                                                        <asp:ListItem Text="Quotation" Value="Quotation" />
                                                    </asp:DropDownList>
                                                </div>
                                                <div id="divLoad1" runat="server" clientidmode="Static" class="input-field col m3">
                                                    <label class="active" runat="server" clientidmode="Static" id="lblReferenceType" for="drpReferenceNo">Inquiry No</label>
                                                    <%--<asp:DropDownList ID="drpReferenceNo" runat="server" class="select2-size-sm browser-default" ClientIDMode="Static" TabIndex="6" multiple="multiple" />--%>
                                                    <asp:listbox runat="server" id="drpReferenceNo" selectionmode="Multiple" style="width: 200px;" ClientIDMode="Static" EnableViewState="true" TabIndex="6" CssClass="select2-size-sm browser-default" AutoPostBack="true"></asp:listbox>                                                </div>
                                                <div id="divLoad2" runat="server" clientidmode="Static" class="input-field col m1">
                                                    <button id="btnLoadItems" type="button" runat="server" clientidmode="Static" tabindex="7" class="btn cyan right mr-1" onclick="javascript:getSelectedOrders();" onserverclick="btnLoadItems_Click">Load Products</button>
                                                </div>
                                                <div id="divEmployee" runat="server" clientidmode="static" class="input-field col m2">
                                                    <label class="active" for="drpSalesPerson">Sales Executive</label>
                                                    <asp:DropDownList ID="drpSalesPerson" runat="server" class="select2-theme browser-default" EnableViewState="true" ClientIDMode="Static" TabIndex="8">
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="input-field col m2" style="display:block;">
                                                    <label class="active" for="txtReference">Reference No.</label>
                                                    <asp:TextBox ID="txtReference" runat="server" class="form-control" ClientIDMode="Static" TabIndex="9" placeholder="" MaxLength="20" />
                                                </div>
                                                <div class="input-field col m2" style="display:block;">
                                                    <label class="active" for="txtReferenceDate"><% if (hdnSerialKey.Value == "BLUE-CHEM-56JK-BC88") { %>L.R. Date <% } else {%> Reference Date <%} %></label>
                                                    <asp:TextBox ID="txtReferenceDate" runat="server" class="form-control" ClientIDMode="Static" TabIndex="10" placeholder="" TextMode="Date" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="input-field col m2">
                                                    <label class="active" for="txtDelDate"><% if (hdnSerialKey.Value == "ACSI-C803-CUP0-SHEL") { %>W.O DATE <% } else {%> Delivery Date <%} %></label>
                                                    <asp:TextBox ID="txtDelDate" runat="server" class="form-control" ClientIDMode="Static" TabIndex="11" placeholder="" TextMode="Date" />
                                                </div>
                                                <div class="input-field col m2">
                                                    <label class="active" for="drpProjects" style="margin-left: 15px;">Projects </label>
                                                    <asp:DropDownList ID="drpProjects" runat="server" class="select2-theme browser-default" EnableViewState="true" ClientIDMode="Static" TabIndex="12" />
                                                </div>
                                                <% if (hdnQuotationCurrency.Value.ToLower() == "yes" || hdnQuotationCurrency.Value.ToLower() == "y")
                                                                                                          { %>
                                                <div class="input-field col m2">
                                                    <label class="active" for="drpCurrency">Select Currency</label>
                                                    <asp:DropDownList ID="drpCurrency" runat="server" class="select2-theme browser-default" data-placeholder="" EnableViewState="true" ClientIDMode="Static" TabIndex="13" />
                                                </div>
                                                <div class="input-field col m1.5">
                                                    <label class="active" for="txtExchangeRate">Exchange Rate</label>
                                                    <asp:TextBox ID="txtExchangeRate" runat="server" MaxLength="12" placeholder="" class="form-control" ClientIDMode="Static" TabIndex="14" />
                                                </div>
                                                <% } %>
                                                <div class="input-field col m1.5">
                                                    <label class="active" for="txtCreditDays">Credit Days</label>
                                                    <asp:TextBox ID="txtCreditDays" runat="server" MaxLength="50" placeholder="" class="form-control" ClientIDMode="Static" TabIndex="14" />
                                                </div>
                                                <div class="input-field col m1.5">
                                                    <label class="active" for="txtWONo">Work Order No.</label>
                                                    <asp:TextBox ID="txtWONo" runat="server" class="form-control" ClientIDMode="Static" TabIndex="15" placeholder="" />
                                                </div>
                                                <div class="input-field col m1.5">
                                                    <label class="active" for="txtWODate">Work Order Date </label>
                                                    <asp:TextBox ID="txtWODate" runat="server" class="form-control" ClientIDMode="Static" TabIndex="16" placeholder="" TextMode="Date" />
                                                </div>
                                                <div class="input-field col m0" style="visibility: hidden">
                                                    <label class="active" for="drpApprovalStatus" style="margin-left: 15px;">Approval Status</label>
                                                    <asp:DropDownList ID="drpApprovalStatus" runat="server" class="select2-theme browser-default" EnableViewState="true" ClientIDMode="Static" TabIndex="15" disabled="true">
                                                        <asp:ListItem Text="Pending" Value="Pending" />
                                                        <asp:ListItem Text="On Hold" Value="On Hold" />
                                                        <asp:ListItem Text="Approved" Value="Approved" />
                                                        <asp:ListItem Text="Dispatched" Value="Dispatched" />
                                                        <asp:ListItem Text="Rejected" Value="Rejected" />
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col s12">
                                            <ul id="Ul1" class="tabs" runat="server" clientidmode="Static" enableviewstate="true" style="background-color: antiquewhite;">
                                                <li class="tab col m1.5 p-0"><a id="lnkProducts" class="left active" href="#pnl_Products">Product Detail</a></li>
                                                <li class="tab col m1.5 p-0"><a id="lnkTNC" class="left" href="#pnl_TNC" tabindex="28">Terms & Coditions</a></li>
                                                <li class="tab col m1.5 p-0"><a id="lnkEmail" class="left" href="#pnl_Email" tabindex="33">Email Content</a></li>
                                                <li class="tab col m1.5 p-0"><a id="lnkPaySch" class="left" href="#pnl_PaySch" tabindex="37">Payment Schedule</a></li>
                                                <li class="tab col m1.5 p-0"><a id="lnkShipment" class="left" href="#pnl_Shipment" tabindex="44">Shipment Detail</a></li>

                                                 <% if (hdnSerialKey.Value == "SHSI-JA98-NA3S-51SD")
                                                    { %>
                                                <li class="tab col m1.5 p-0"><a id="lnkProduction" class="left" href="#pnl_Production" tabindex="79">Production Detail</a></li>
                                                <% } %>
                                                <li class="tab col m1.5 p-0"><a id="lnkAttachment" class="left" href="#pnl_Attachment" tabindex="57">Attachment</a></li>
                                                <li class="tab col m1.5 p-0"><a id="lnkshipmentaddress" class="left" href="#pnl_ShipmentAddress" tabindex="44">Shipment Address</a></li>
                                            </ul>
                                        </div>
                                        <div id="pnl_Products" class="col m12 mt-1" runat="server" clientidmode="Static" enableviewstate="true" style="display: block;">
                                            <asp:Panel runat="server" ID="pnlDetail">
                                                <div class="row">
                                                    <table id="tblQuotationDetail" class="table responsive-table striped width-100">
                                                        <asp:Repeater ID="rptOrderDetail" runat="server" ClientIDMode="Static" OnItemCommand="rptOrderDetail_ItemCommand" OnItemDataBound="rptOrderDetail_ItemDataBound">
                                                            <HeaderTemplate>
                                                                <thead>
                                                                    <tr>
                                                                        <th class="left-align" style="width: 25%;">Product Name <span class="materialize-red-text font-weight-800">*</span>
                                                                            <a href="javascript:openProductInfo('add');">
                                                                                <img src="images/expand.png" width="30" height="20" style="padding: 5px 5px 0px 10px;" alt="Add New Product" title="Add New Product" tabindex="13" />
                                                                            </a>
                                                                        </th>
                                                                        <th class="center-align">Unit</th>
                                                                        <% if (hdnSerialKey.Value == "SA98-6HY9-HU67-LORF")
                                                                            { %>
                                                                        <th class="right-align">Unit Qty </th>
                                                                        <% } %>
                                                                        <th class="right-align" style="width: 8%;">Quantity <span class="materialize-red-text font-weight-800">*</span></th>
                                                                        <th class="center-align" style="width: 8%;">Unit Rate<span class="materialize-red-text font-weight-800">*</span></th>
                                                                        <th class="right-align">Disc. %</th>
                                                                        <th class="right-align hide">Disc.Amt</th>
                                                                        <th class="right-align hide">Net Rate</th>
                                                                        <th class="text-right hide">Header Disc</th>
                                                                        <th class="center-align width-7">Amount</th>
                                                                        <th class="right-align width-5">Tax %</th>
                                                                        <th class="center-align width-7">Tax Amount</th>
                                                                        <th class="center-align" style="width: 10%;">Net Amount</th>
                                                                        <th class="center-align" style="width: 10%;">Delivery Date</th>
                                                                        <% if (hdnQuotationSpecification.Value.ToLower() == "yes")
                                                                            { %>
                                                                        <th class="center-align width-5">Specs</th>
                                                                        <% } %>
                                                                        <th class="center-align width-5">Assembly</th>
                                                                        <th class="center-align width-5" >Delete</th>
                                                                    </tr>
                                                                </thead>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <tr>
                                                                    <td class="left-align" style="width: 25%;">
                                                                        <%# Eval("ProductNameLong") %>
                                                                        <asp:HiddenField ID="edDocRefNo" runat="server" ClientIDMode="Static" Value='<%# Eval("DocRefNo") %>' />
                                                                        <asp:HiddenField ID="edProductID" runat="server" ClientIDMode="Static" Value='<%# Eval("ProductID") %>' />
                                                                        <asp:HiddenField ID="edProductName" runat="server" ClientIDMode="Static" Value='<%# Eval("ProductName") %>' />
                                                                        <asp:HiddenField ID="edTaxType" runat="server" ClientIDMode="Static" Value='<%# Eval("TaxType") %>' />
                                                                        <asp:HiddenField ID="edBox_SQFT" runat="server" ClientIDMode="Static" Value='<%# Eval("Box_SQFT") %>' />
                                                                        <asp:HiddenField ID="edBox_SQMT" runat="server" ClientIDMode="Static" Value='<%# Eval("Box_SQMT") %>' />
                                                                        <asp:HiddenField ID="edUnitQuantity" runat="server" ClientIDMode="Static" Value='<%# Eval("UnitQuantity") %>' />
                                                                    </td>
                                                                    <td class="text-center">
                                                                        <asp:TextBox ID="edUnit" MaxLength="15" runat="server" ClientIDMode="Static" Text='<%# Eval("Unit") %>' AutoPostBack="true" OnTextChanged="editItem_TextChanged" Style="width: 70px; text-align: right;" TabIndex="12"  />
                                                                    </td>
                                                                    <% if (hdnSerialKey.Value == "SA98-6HY9-HU67-LORF")
                                                                        { %>
                                                                    <td class="right-align" style="width: 8%;">
                                                                        <asp:TextBox ID="edUnitQty" runat="server" ClientIDMode="Static" Text='<%# Eval("UnitQty") %>' AutoPostBack="true" OnTextChanged="editItem_TextChanged" Style="width: 70px; text-align: right;" TabIndex="14" />
                                                                    </td>
                                                                    <% } %>
                                                                    <td class="right-align" style="width: 8%;">
                                                                        <asp:TextBox ID="edQuantity" runat="server" ClientIDMode="Static" Text='<%# Eval("Quantity") %>' AutoPostBack="true" OnTextChanged="editItem_TextChanged" Style="width: 70px; text-align: right;" TabIndex="15" />
                                                                    </td>
                                                                    <td class="right-align" style="width: 8%;">
                                                                        <asp:TextBox ID="edUnitRate" runat="server" ClientIDMode="Static" Text='<%# Eval("UnitRate") %>' AutoPostBack="true" OnTextChanged="editItem_TextChanged" Style="width: 70px; text-align: right;" TabIndex="16" />
                                                                    </td>
                                                                    <td class="right-align">
                                                                        <asp:TextBox ID="edDiscountPercent" runat="server" ClientIDMode="Static" Text='<%# Eval("DiscountPercent") %>' AutoPostBack="true" OnTextChanged="editItem_TextChanged" Style="width: 50px; text-align: right;" TabIndex="17" />
                                                                    </td>
                                                                    <td class="right-align hide">
                                                                        <asp:TextBox ID="edDiscountAmt" runat="server" ClientIDMode="Static" Text='<%# Eval("DiscountAmt") %>' OnTextChanged="editItem_TextChanged" Style="width: 80px; text-align: right;" Enabled="false" TabIndex="18" />
                                                                    </td>
                                                                    <td class="right-align hide">
                                                                        <asp:TextBox ID="edNetRate" runat="server" ClientIDMode="Static" Text='<%# Eval("NetRate") %>' Style="width: 80px; text-align: right;" Enabled="false" TabIndex="19" />
                                                                    </td>
                                                                    <td class="text-right hide">
                                                                        <asp:TextBox ID="edHeaderDiscAmt" runat="server" ClientIDMode="Static" Text='<%# Eval("HeaderDiscAmt") %>' Style="width: 80px; text-align: right;" Enabled="false" TabIndex="20" CssClass="form-control" />
                                                                    </td>
                                                                    <td class="right-align width-7">
                                                                        <asp:TextBox ID="edAmount" runat="server" ClientIDMode="Static" Text='<%# Eval("Amount") %>' Style="width: 90px; text-align: right;" Enabled="false" TabIndex="21" />
                                                                    </td>
                                                                    <td class="right-align width-5">
                                                                        <asp:HiddenField ID="edhdnCGSTPer" runat="server" ClientIDMode="Static" Value='<%# Eval("CGSTPer") %>' />
                                                                        <asp:HiddenField ID="edhdnSGSTPer" runat="server" ClientIDMode="Static" Value='<%# Eval("SGSTPer") %>' />
                                                                        <asp:HiddenField ID="edhdnIGSTPer" runat="server" ClientIDMode="Static" Value='<%# Eval("IGSTPer") %>' />
                                                                        <asp:TextBox ID="edTaxRate" runat="server" ClientIDMode="Static" Text='<%# Eval("TaxRate") %>' AutoPostBack="true" OnTextChanged="editItem_TextChanged" Style="width: 50px; text-align: right;" TabIndex="22" />
                                                                    </td>
                                                                    <td class="right-align width-7">
                                                                        <asp:HiddenField ID="edhdnCGSTAmt" runat="server" ClientIDMode="Static" Value='<%# Eval("CGSTAmt") %>' />
                                                                        <asp:HiddenField ID="edhdnSGSTAmt" runat="server" ClientIDMode="Static" Value='<%# Eval("SGSTAmt") %>' />
                                                                        <asp:HiddenField ID="edhdnIGSTAmt" runat="server" ClientIDMode="Static" Value='<%# Eval("IGSTAmt") %>' />
                                                                        <asp:TextBox ID="edTaxAmount" runat="server" ClientIDMode="Static" Text='<%# Eval("TaxAmount") %>' AutoPostBack="true" Style="width: 90px; text-align: right;" Enabled="false" TabIndex="23" />
                                                                    </td>
                                                                    <td class="right-align" style="width: 10%;">
                                                                        <asp:TextBox ID="edNetAmount" runat="server" ClientIDMode="Static" Text='<%# Eval("NetAmount") %>' AutoPostBack="true" Style="width: 90px; text-align: right;" Enabled="false" TabIndex="24" />
                                                                    </td>
                                                                    <td class="right-align" style="width: 10%;">
                                                                        <asp:TextBox ID="edDelDate" runat="server" ClientIDMode="Static" Text='<%# Eval("DeliveryDate","{0:yyyy-MM-dd}") %>' AutoPostBack="true" Style="width: 130px; text-align: right;" TabIndex="25" placeholder="" TextMode="Date"  OnTextChanged="editItem_TextChanged" /> 
                                                                    </td>
                                                                    <% if (hdnQuotationSpecification.Value.ToLower() == "yes")
                                                                        { %>
                                                                    <td class="center-align width-5" >
                                                                        <a id="lnkSpecs" href="javascript:openSpecification('<%# Eval("ProductID") %>');" tabindex="26"><small>Specs</small></a>
                                                                    </td>
                                                                    <% } %>
                                                                    <td class="center-align width-5" >
                                                                        <a id="lnkAssembly" href="javascript:openAssembly('<%# Eval("ProductID") %>');" tabindex="19"><small>Assembly</small></a>
                                                                    </td>
                                                                    <td class="center-align width-5" >
                                                                        <asp:ImageButton ID="ImgbtnDelete" runat="server" ClientIDMode="Static" ImageUrl="~/images/delete.png" ToolTip="Delete" CommandName="Delete" CommandArgument='<%# Eval("pkID") %>' Width="20" Height="20" TabIndex="27" />
                                                                    </td>
                                                                </tr>
                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                                <tr style="background-color: #dde8f3; border-bottom: 5px solid navy;">
                                                                    <td class="left-align" style="width: 25%;">
                                                                        <asp:HiddenField ID="hdnDocRefNo" runat="server" ClientIDMode="Static" />
                                                                        <asp:HiddenField ID="hdnProductID" runat="server" ClientIDMode="Static" />
                                                                        <asp:HiddenField ID="hdnTaxType" runat="server" ClientIDMode="Static" />
                                                                        <asp:HiddenField ID="hdnOrgUnitRate" runat="server" ClientIDMode="Static" />
                                                                        <asp:HiddenField ID="hdnBox_SQFT" runat="server" ClientIDMode="Static" />
                                                                        <asp:HiddenField ID="hdnBox_SQMT" runat="server" ClientIDMode="Static" />
                                                                        <asp:HiddenField ID="hdnUnitQuantity" runat="server" ClientIDMode="Static" />
                                                                        <asp:TextBox ID="txtProductName" runat="server" ClientIDMode="Static" class="form-control" onKeyup="bindDDLProductTo('#txtProductName')" AutoPostBack="true" OnTextChanged="txtProductName_TextChanged" Width="100%" TabIndex="28" />
                                                                    </td>
                                                                    <td class="center-align">
                                                                        <asp:TextBox ID="txtUnit" runat="server" ClientIDMode="Static" Width="50" TabIndex="29" AutoPostBack="true" OnTextChanged="txtUnit_TextChanged" />
                                                                    </td>
                                                                    <% if (hdnSerialKey.Value == "SA98-6HY9-HU67-LORF")
                                                                        { %>
                                                                    <td class="right-align" style="width: 8%;">
                                                                        <asp:TextBox ID="txtUnitQty" runat="server" ClientIDMode="Static" Width="70" AutoPostBack="true" OnTextChanged="txtUnitQty_TextChanged" TabIndex="30" MaxLength="10" />
                                                                    </td>
                                                                    <% } %>
                                                                    <td class="right-align" style="width: 8%;">
                                                                        <asp:TextBox ID="txtQuantity" runat="server" ClientIDMode="Static" Width="70" TabIndex="31" AutoPostBack="true" OnTextChanged="txtQuantity_TextChanged" />
                                                                    </td>
                                                                    <td class="right-align" style="width: 8%;">
                                                                        <asp:TextBox ID="txtUnitRate" runat="server" ClientIDMode="Static" Width="80" TabIndex="32" AutoPostBack="true" OnTextChanged="txtUnitRate_TextChanged" />
                                                                    </td>
                                                                    <td class="right-align">
                                                                        <asp:TextBox ID="txtDiscountPercent" runat="server" ClientIDMode="Static" Width="50" TabIndex="33" AutoPostBack="true" OnTextChanged="txtDiscountPercent_TextChanged" />
                                                                    </td>
                                                                    <td class="right-align hide">
                                                                        <asp:TextBox ID="txtDiscountAmt" runat="server" ClientIDMode="Static" Width="80" TabIndex="34" Enabled="false" />
                                                                    </td>
                                                                    <td class="right-align hide">
                                                                        <asp:TextBox ID="txtNetRate" runat="server" ClientIDMode="Static" Width="80" TabIndex="35" Enabled="false" />
                                                                    </td>
                                                                    <td class="text-right hide">
                                                                        <asp:TextBox ID="txtHeaderDiscAmt" runat="server" ClientIDMode="Static" Width="80" TabIndex="36" Enabled="false" CssClass="form-control" />
                                                                    </td>
                                                                    <td class="right-align width-7">
                                                                        <asp:TextBox ID="txtAmount" runat="server" ClientIDMode="Static" Width="90" TabIndex="37" Enabled="false" />
                                                                    </td>
                                                                    <td class="right-align width-5">
                                                                        <asp:HiddenField ID="hdnCGSTPer" runat="server" ClientIDMode="Static" />
                                                                        <asp:HiddenField ID="hdnSGSTPer" runat="server" ClientIDMode="Static" />
                                                                        <asp:HiddenField ID="hdnIGSTPer" runat="server" ClientIDMode="Static" />
                                                                        <asp:TextBox ID="txtTaxRate" runat="server" ClientIDMode="Static" Width="50" TabIndex="38" AutoPostBack="true" OnTextChanged="txtTaxRate_TextChanged" />
                                                                    </td>
                                                                    <td class="right-align width-7">
                                                                        <asp:HiddenField ID="hdnCGSTAmt" runat="server" ClientIDMode="Static" />
                                                                        <asp:HiddenField ID="hdnSGSTAmt" runat="server" ClientIDMode="Static" />
                                                                        <asp:HiddenField ID="hdnIGSTAmt" runat="server" ClientIDMode="Static" />
                                                                        <asp:TextBox ID="txtTaxAmount" runat="server" ClientIDMode="Static" Width="90" TabIndex="39" Enabled="false" />
                                                                    </td>
                                                                    <td class="right-align" style="width: 10%;">
                                                                        <asp:TextBox ID="txtNetAmount" runat="server" ClientIDMode="Static" Width="90" TabIndex="40" Enabled="false" />
                                                                    </td>
                                                                    <td class="right-align" style="width: 10%;">
                                                                        <asp:TextBox ID="txtDelDate" runat="server" ClientIDMode="Static" Width="130" TabIndex="41" Enabled="true" TextMode="Date" />
                                                                    </td>
                                                                    <td class="center-align" colspan="3" style="width: 20%;">
                                                                        <asp:ImageButton ID="imgBtnSave" runat="server" ImageUrl="~/images/buttons/bt-add2.png" ToolTip="Add Item" CommandName="Save" CommandArgument='0' Width="110" Height="30" TabIndex="42" />
                                                                    </td>
                                                                </tr>
                                                                <tr class="hide" style="background-color: navy; min-height: 50px;">
                                                                    <td class="text-right" colspan="5" style="color: White; font-size: 16px;">Grand Total: </td>
                                                                    <td class="text-right" style="display: none;">
                                                                        <asp:Label ID="lblTotalDiscAmt" runat="server" ClientIDMode="Static" Width="100" TabIndex="43" Enabled="false" Style="color: White; font-size: 16px;" />
                                                                    </td>
                                                                    <td class="text-right" style="color: White; font-size: 16px;"></td>
                                                                    <td class="text-right">
                                                                        <asp:Label ID="lblTotalAmt" runat="server" ClientIDMode="Static" Width="100" TabIndex="44" Enabled="false" Style="color: White; font-size: 16px;" />
                                                                    </td>
                                                                    <td class="text-right" style="color: White; font-size: 16px;"></td>

                                                                    <td class="text-right">
                                                                        <asp:Label ID="lblTotalTaxAmount" runat="server" ClientIDMode="Static" Width="100" TabIndex="45" Enabled="false" Style="color: White; font-size: 16px;" />
                                                                    </td>
                                                                    <td class="text-right">
                                                                        <asp:Label ID="lblTotalNetAmount" runat="server" ClientIDMode="Static" Width="100" TabIndex="46" Enabled="false" Style="color: White; font-size: 16px;" />
                                                                    </td>
                                                                    <td colspan="2"></td>
                                                                </tr>
                                                            </FooterTemplate>
                                                        </asp:Repeater>
                                                    </table>
                                                </div>
                                            </asp:Panel>
                                            <div class="row mt-1">
                                                <div class="col m3">
                                                    <asp:HiddenField ID="hdnOthChrgGST1" runat="server" ClientIDMode="Static" />
                                                    <asp:HiddenField ID="hdnOthChrgBasic1" runat="server" ClientIDMode="Static" />
                                                    <asp:HiddenField ID="hdnOthChrgGST2" runat="server" ClientIDMode="Static" />
                                                    <asp:HiddenField ID="hdnOthChrgBasic2" runat="server" ClientIDMode="Static" />
                                                    <asp:HiddenField ID="hdnOthChrgGST3" runat="server" ClientIDMode="Static" />
                                                    <asp:HiddenField ID="hdnOthChrgBasic3" runat="server" ClientIDMode="Static" />
                                                    <asp:HiddenField ID="hdnOthChrgGST4" runat="server" ClientIDMode="Static" />
                                                    <asp:HiddenField ID="hdnOthChrgBasic4" runat="server" ClientIDMode="Static" />
                                                    <asp:HiddenField ID="hdnOthChrgGST5" runat="server" ClientIDMode="Static" />
                                                    <asp:HiddenField ID="hdnOthChrgBasic5" runat="server" ClientIDMode="Static" />
                                                    <table id="tblCharge" class="table responsive-table striped width-100" cellpadding="0" cellspacing="0" border="0" width="100%">
                                                        <tbody>
                                                            <tr>
                                                                <td class="width-70">
                                                                    <asp:DropDownList ID="drpOthChrg1" runat="server" class="select2-theme browser-default" EnableViewState="true" ClientIDMode="Static" TabIndex="15" AutoPostBack="true" OnSelectedIndexChanged="drpOthChrg1_SelectedIndexChanged" />
                                                                </td>
                                                                <td class="width-30">
                                                                    <asp:TextBox ID="txtOthChrgAmt1" class="form-control inputOther" runat="server" ClientIDMode="Static" TabIndex="16" AutoPostBack="true" OnTextChanged="txtOthChrgAmt1_TextChanged" Style="text-align: right;" MaxLength="12" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="width-70">
                                                                    <asp:DropDownList ID="drpOthChrg2" runat="server" class="select2-theme browser-default" EnableViewState="true" ClientIDMode="Static" TabIndex="17" AutoPostBack="true" OnSelectedIndexChanged="drpOthChrg2_SelectedIndexChanged" />
                                                                </td>
                                                                <td class="width-30">
                                                                    <asp:TextBox ID="txtOthChrgAmt2" class="form-control inputOther" runat="server" ClientIDMode="Static" TabIndex="18" AutoPostBack="true" OnTextChanged="txtOthChrgAmt2_TextChanged" Style="text-align: right;" MaxLength="12"/>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="width-70">
                                                                    <asp:DropDownList ID="drpOthChrg3" runat="server" class="select2-theme browser-default" EnableViewState="true" ClientIDMode="Static" TabIndex="19" AutoPostBack="true" OnSelectedIndexChanged="drpOthChrg3_SelectedIndexChanged" />
                                                                </td>
                                                                <td class="width-30">
                                                                    <asp:TextBox ID="txtOthChrgAmt3" class="form-control inputOther" runat="server" ClientIDMode="Static" TabIndex="20" AutoPostBack="true" OnTextChanged="txtOthChrgAmt3_TextChanged" Style="text-align: right;" MaxLength="12"/>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="width-70">
                                                                    <asp:DropDownList ID="drpOthChrg4" runat="server" class="select2-theme browser-default" EnableViewState="true" ClientIDMode="Static" TabIndex="21" AutoPostBack="true" OnSelectedIndexChanged="drpOthChrg4_SelectedIndexChanged" MaxLength="12"/>
                                                                </td>
                                                                <td class="width-30">
                                                                    <asp:TextBox ID="txtOthChrgAmt4" class="form-control inputOther" runat="server" ClientIDMode="Static" TabIndex="22" AutoPostBack="true" OnTextChanged="txtOthChrgAmt4_TextChanged" Style="text-align: right;" MaxLength="12"/>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="width-70">
                                                                    <asp:DropDownList ID="drpOthChrg5" runat="server" class="select2-theme browser-default" EnableViewState="true" ClientIDMode="Static" TabIndex="23" AutoPostBack="true" OnSelectedIndexChanged="drpOthChrg5_SelectedIndexChanged" />
                                                                </td>
                                                                <td class="width-30">
                                                                    <asp:TextBox ID="txtOthChrgAmt5" class="form-control inputOther" runat="server" ClientIDMode="Static" TabIndex="24" AutoPostBack="true" OnTextChanged="txtOthChrgAmt5_TextChanged" Style="text-align: right;" MaxLength="12"/>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                                <div class="col m9">
                                                    <table id="tblSummary" class="table responsive-table striped" border="0">
                                                        <tbody>
                                                            <tr class="border-none">
                                                                <td class="width-80 right-align">Discount Amount</td>
                                                                <td class="width-20">
                                                                    <asp:TextBox ID="txtHeadDiscount" class="form-control inputCalc" runat="server" ClientIDMode="Static" TabIndex="25" AutoPostBack="true" OnTextChanged="txtHeadDiscount_TextChanged" MaxLength="12"/>
                                                                </td>
                                                            </tr>

                                                            <tr class="border-none">
                                                                <td class="width-80 right-align">Basic Amount</td>
                                                                <td class="width-20">
                                                                    <asp:TextBox ID="txtTotBasicAmt" class="form-control inputCalc" runat="server" ClientIDMode="Static" TabIndex="58" ReadOnly="true" MaxLength="12" />
                                                                </td>
                                                            </tr>
                                                            <tr class="border-none">
                                                                <td class="width-80 right-align">Other Charge <small style="color: navy; font-weight: 600;">(With Tax)</small></td>
                                                                <td class="width-20">
                                                                    <asp:TextBox ID="txtTotOthChrgBeforeGST" class="form-control inputCalc" runat="server" ClientIDMode="Static" TabIndex="59" ReadOnly="true"  MaxLength="12"/>
                                                                </td>
                                                            </tr>
                                                            <tr class="border-none">
                                                                <asp:HiddenField ID="hdnTotCGSTAmt" runat="server" ClientIDMode="Static" />
                                                                <asp:HiddenField ID="hdnTotSGSTAmt" runat="server" ClientIDMode="Static" />
                                                                <asp:HiddenField ID="hdnTotIGSTAmt" runat="server" ClientIDMode="Static" />
                                                                <td class="width-80 right-align">Total GST</td>
                                                                <td class="width-20">
                                                                    <asp:HiddenField ID="hdnTotItemGST" runat="server" ClientIDMode="Static" />
                                                                    <asp:TextBox ID="txtTotGST" class="form-control inputCalc" runat="server" ClientIDMode="Static" TabIndex="60" ReadOnly="true" />
                                                                </td>
                                                            </tr>
                                                            <tr class="border-none">
                                                                <td class="width-80 right-align">Other Charges <small style="color: Navy; font-weight: 600;">(Excluding Tax)</small></td>
                                                                <td class="width-20">
                                                                    <asp:TextBox ID="txtTotOthChrgAfterGST" class="form-control inputCalc" runat="server" ClientIDMode="Static" TabIndex="61" ReadOnly="true" />
                                                                </td>
                                                            </tr>
                                                            <tr class="border-none">
                                                                <td class="width-80 right-align">Round Off</td>
                                                                <td class="width-20">
                                                                    <asp:TextBox ID="txtRoff" class="form-control inputCalc" runat="server" ClientIDMode="Static" TabIndex="62" ReadOnly="true" />
                                                                </td>
                                                            </tr>
                                                            <tr class="border-none">
                                                                <td class="width-80 right-align">Net Amount</td>
                                                                <td class="width-20">
                                                                    <asp:TextBox ID="txtTotNetAmt" class="form-control inputCalc" runat="server" ClientIDMode="Static" TabIndex="63" ReadOnly="true" Style="font-weight: bold;" />
                                                                </td>
                                                            </tr>
                                                            <tr class="border-none">
                                                                <td class="width-70 right-align">Adv.%</td>
                                                                <td class="width-30">
                                                                    <table class="table responsive-table striped">
                                                                        <tbody>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:TextBox ID="txtAdvPer" class="form-control" runat="server" ClientIDMode="Static" TabIndex="26" Style="font-weight: bold; width: 50px;" ToolTip="Advance Percentage" placeholder="" AutoPostBack="true" OnTextChanged="txtAdvPer_TextChanged" MaxLength="12"/></td>
                                                                                <td><span>Amt</span></td>
                                                                                <td>
                                                                                    <asp:TextBox ID="txtAdvAmt" class="form-control inputCalc" runat="server" ClientIDMode="Static" TabIndex="27" Style="font-weight: bold; width: 80px;" ToolTip="Advance Amount" MaxLength="12"/></td>
                                                                            </tr>
                                                                        </tbody>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                        <div id="pnl_Email" class="col m12 mt-1" runat="server" clientidmode="Static" enableviewstate="true" style="display: none;">

                                            <div class="row">
                                                <div class="input-field col m2">
                                                    <label class="active" for="drpEmailCategory">Select Subject</label>
                                                    <asp:DropDownList ID="drpEmailCategory" runat="server" ClientIDMode="Static" class="select2-theme browser-default" EnableViewState="true" TabIndex="34" Width="200px" AutoPostBack="true" OnSelectedIndexChanged="drpQuotationCategory_SelectedIndexChanged" />
                                                </div>
                                                <div class="input-field col m10">
                                                    <%--Section : Add New Entry --%>
                                                    <a class="material-icons background-round gradient-45deg-purple-amber gradient-shadow white-text float-Left tooltipped ml-5 mr-2" data-position="center" data-tooltip="Add New Entry" href="javascript:gridAction('add','<%# drpEmailCategory.SelectedValue %>');" style="padding: 5px;"><i class="material-icons">add</i></a>
                                                </div>
                                                <div class="input-field col m12">
                                                    <label class="active" for="txtQuotationSubject">Subject</label>
                                                    <asp:TextBox ID="txtEmailSubject" runat="server" placeholder="" class="form-control" ClientIDMode="Static" MaxLength="1500" TabIndex="35" />
                                                </div>
                                                <div class="input-field col m12">
                                                    <label class="active" for="txtQuotationHeader">Email Introduction</label>
                                                    <asp:TextBox ID="txtEmailHeader" MaxLength="500" runat="server" class="form-control" ClientIDMode="Static" TabIndex="36" TextMode="MultiLine" Rows="13" placeholder="" />
                                                </div>
                                            </div>
                                        </div>
                                        <div id="pnl_TNC" class="col m12 mt-1" runat="server" clientidmode="Static" enableviewstate="true" style="display: none;">
                                            <div class="row">
                                                <div class="input-field col m12">
                                                    <label class="active" for="txtExchangeRate">Select Terms & Conditions</label>
                                                    <asp:DropDownList ID="drpTNC" runat="server" ClientIDMode="Static" class="select2-theme browser-default" EnableViewState="true" TabIndex="29" Width="200px" AutoPostBack="true" OnSelectedIndexChanged="drpTNC_SelectedIndexChanged" />
                                                </div>
                                                <div class="input-field col m12">
                                                    <label class="active" for="txtTermsCondition">Terms & Condition</label>
                                                    <asp:TextBox ID="txtTermsCondition" runat="server" class="form-control" ClientIDMode="Static" TabIndex="30" TextMode="MultiLine" Rows="20" Height="100px" placeholder="" MaxLength="500"/>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="input-field col m6">
                                                    <label class="active" for="txtDelTerms">Delivery Terms</label>
                                                    <asp:TextBox ID="txtDelTerms" runat="server" class="form-control" ClientIDMode="Static" TabIndex="31" TextMode="MultiLine" Rows="20" placeholder="" MaxLength="500"/>
                                                </div>
                                                <div class="input-field col m6">
                                                    <label class="active" for="txtPayTerms">Payment Terms</label>
                                                    <asp:TextBox ID="txtPayTerms" runat="server" class="form-control" ClientIDMode="Static" TabIndex="32" TextMode="MultiLine" Rows="20" placeholder="" MaxLength="100"/>
                                                </div>
                                            </div>

                                        </div>

                                        <div id="pnl_PaySch" class="col m12 mt-1" runat="server" clientidmode="Static" enableviewstate="true" style="display: none;">
                                            <table id="tblPaySchedule" class="table responsive-table striped">
                                                <asp:Repeater ID="rptPaySchedule" runat="server" ClientIDMode="Static" OnItemCommand="rptPaySchedule_ItemCommand">
                                                    <HeaderTemplate>
                                                        <thead>
                                                            <tr>
                                                                <th class="right-align width-30">Amount</th>
                                                                <th class="center-align width-30">Due Date</th>
                                                                <th class="center-align width-40">Action</th>
                                                            </tr>
                                                        </thead>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td class="right-align width-30">
                                                                <asp:TextBox ID="edPayAmount" runat="server" ClientIDMode="Static" CssClass="form-control text-right" Text='<%# Eval("PayAmount") %>' AutoPostBack="true" TabIndex="38" />
                                                            </td>
                                                            <td class="center-align width-30">
                                                                <asp:TextBox ID="edDueDate" runat="server" ClientIDMode="Static" CssClass="datepicker" Text='<%# Eval("DueDate", "{0:yyyy-MM-dd}") %>' AutoPostBack="true" Width="180px" TabIndex="39" />
                                                            </td>
                                                            <td class="center-align width-40">
                                                                <asp:ImageButton ID="ImgbtnEdit11" runat="server" ClientIDMode="Static" ImageUrl="~/images/savedata.png" ToolTip="Update" CommandName="updpayment" CommandArgument='<%# Eval("pkID") %>' Width="40" Height="20" TabIndex="74" Visible="false" />
                                                                <asp:ImageButton ID="ImgbtnDelete11" runat="server" ClientIDMode="Static" ImageUrl="~/images/delete.png" ToolTip="Delete" CommandName="delpayment" CommandArgument='<%# Eval("pkID") %>' Width="20" Height="20" TabIndex="40" />
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <tr>
                                                            <td class="right-align width-30">
                                                                <asp:TextBox ID="ftPayAmount" runat="server" ClientIDMode="Static" CssClass="form-control text-right" Text='<%# Eval("PayAmount") %>' AutoPostBack="true" TabIndex="41" />
                                                            </td>
                                                            <td class="center-align width-30">
                                                                <asp:TextBox ID="ftDueDate" runat="server" ClientIDMode="Static" Class="form-control" Text='<%# Eval("DueDate", "{0:yyyy-MM-dd}") %>' AutoPostBack="true" Width="180px" TabIndex="42" TextMode="Date" />
                                                            </td>
                                                            <td class="center-align width-40">
                                                                <asp:ImageButton ID="ImgbtnAddSch" runat="server" ClientIDMode="Static" ImageUrl="~/images/expand.png" ToolTip="Add Schedule" CommandName="addpayment" CommandArgument='<%# Eval("pkID") %>' Width="30" Height="30" TabIndex="43" />
                                                            </td>
                                                        </tr>
                                                    </FooterTemplate>
                                                </asp:Repeater>
                                            </table>
                                        </div>

                                        <div id="pnl_Shipment" class="col m12 mt-1" runat="server" clientidmode="Static" enableviewstate="true" style="display: none;">
                                            <div class="row">
                                                <div class="input-field col m4">
                                                    <label class="active" for="txtPreCarrBy">Pre Carriage By (Transporter Name)</label>
                                                    <asp:TextBox ID="txtPreCarrBy" runat="server" class="form-control" ClientIDMode="Static" TabIndex="45" placeholder="" MaxLength="50" />
                                                </div>
                                                <div class="input-field col m4">
                                                    <label class="active" for="txtPreCarrRecPlace">Place Of Rec.By Pre Carrier</label>
                                                    <asp:TextBox ID="txtPreCarrRecPlace" runat="server" class="form-control" ClientIDMode="Static" TabIndex="46" placeholder="" />
                                                </div>
                                                <div class="input-field col m4">
                                                    <label class="active" for="txtFlightNo">Vessel/Flight No</label>
                                                    <asp:TextBox ID="txtFlightNo" runat="server" class="form-control" ClientIDMode="Static" TabIndex="47" placeholder="" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="input-field col m4">
                                                    <label class="active" for="txtPortOfLoading">Port Of Loading</label>
                                                    <asp:TextBox ID="txtPortOfLoading" runat="server" class="form-control" ClientIDMode="Static" TabIndex="48" placeholder="" />
                                                </div>
                                                <div class="input-field col m4">
                                                    <label class="active" for="txtPortOfDispatch">Port Of Dispatch</label>
                                                    <asp:TextBox ID="txtPortOfDispatch" runat="server" class="form-control" ClientIDMode="Static" TabIndex="49" placeholder="" />
                                                </div>
                                                <div class="input-field col m4">
                                                    <label class="active" for="txtPortOfDestination">Port Of Destination</label>
                                                    <asp:TextBox ID="txtPortOfDestination" runat="server" class="form-control" ClientIDMode="Static" TabIndex="50" placeholder="" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="input-field col m4">
                                                    <label class="active" for="txtContainerNo">Container No.</label>
                                                    <asp:TextBox ID="txtContainerNo" runat="server" class="form-control" ClientIDMode="Static" TabIndex="51" placeholder="" />
                                                </div>
                                                <div class="input-field col m4">
                                                    <label class="active" for="txtPackages">Packages</label>
                                                    <asp:TextBox ID="txtPackages" runat="server" class="form-control" ClientIDMode="Static" TabIndex="52" placeholder="" />
                                                </div>
                                                <div class="input-field col m4">
                                                    <label class="active" for="txtPackageType">Type Of Package</label>
                                                    <asp:TextBox ID="txtPackageType" runat="server" class="form-control" ClientIDMode="Static" TabIndex="53" placeholder="" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="input-field col m4">
                                                    <label class="active" for="txtNetWeight">Net Weight(KGs)</label>
                                                    <asp:TextBox ID="txtNetWeight" runat="server" class="form-control" ClientIDMode="Static" TabIndex="54" placeholder="" />
                                                </div>
                                                <div class="input-field col m4">
                                                    <label class="active" for="txtGrossWeight">Gross Weight(KGs)</label>
                                                    <asp:TextBox ID="txtGrossWeight" runat="server" class="form-control" ClientIDMode="Static" TabIndex="55" placeholder="" />
                                                </div>
                                                <div class="input-field col m4">
                                                    <label class="active" for="txtFOB">FOB (Free Of Board)</label>
                                                    <asp:TextBox ID="txtFOB" runat="server" class="form-control" ClientIDMode="Static" TabIndex="56" placeholder="" />
                                                </div>
                                            </div>
                                        </div>

                                        <div id="pnl_ShipmentAddress" class="col m12 mt-1" runat="server" clientidmode="Static" enableviewstate="true" style="display: none;">
                                            <div class="row">
                                                <div class="input-field col m3">
                                                    <asp:TextBox ID="txtSCompnyName" runat="server" TabIndex="33" class="form-control"  ClientIDMode="Static" Placeholder="" MaxLength="100"  />
                                                    <label class="active" for="txtSCompnyName">Company Name</label>
                                                </div>
                                                <div class="input-field col m3">
                                                    <asp:TextBox ID="txtSGSTNo" runat="server" TabIndex="34" class="form-control"  ClientIDMode="Static" Placeholder="" MaxLength="20" />
                                                    <label class="active" for="txtSGSTNo">GST No.</label>
                                                </div>
                                                <div class="input-field col m3">
                                                    <asp:TextBox ID="txtSContactNo" runat="server" TabIndex="34" class="form-control"  ClientIDMode="Static" Placeholder="" MaxLength="20" />
                                                    <label class="active" for="txtSContactNo">Contact No.</label>
                                                </div>
                                                <div class="input-field col m3">
                                                    <asp:TextBox ID="txtSContactPersonName" runat="server" TabIndex="34" class="form-control"  ClientIDMode="Static" Placeholder="" MaxLength="100" />
                                                    <label class="active" for="txtSContactPersonName">Contact Person Name.</label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="input-field col m12">
                                                    <asp:TextBox ID="txtSAddress" runat="server" class="form-control" Placeholder="" TabIndex="35" MaxLength="100"  ClientIDMode="Static" TextMode="MultiLine"/>
                                                    <label class="active" for="txtSAddress">Address </label>
                                                </div>                                
                                            </div>
                                            <div class="row">
                                                <div class="input-field col m3">
                                                    <asp:TextBox ID="txtSArea" runat="server" TabIndex="36" class="form-control"  ClientIDMode="Static" Placeholder="" MaxLength="100"  />
                                                    <label class="active" for="txtSArea">Area</label>
                                                </div>
                                            
                                                <div class="input-field col m3">
                                                    <asp:DropDownList ID="drpSCountry" class="select2-theme browser-default"  runat="server"  ClientIDMode="Static" TabIndex="37" AutoPostBack="true" OnSelectedIndexChanged="drpSCountry_SelectedIndexChanged"  />
                                                    <label class="active" for="drpSCountry">Country </label>
                                                 </div>
                                                <div class="input-field col m3">
                                                    <asp:DropDownList ID="drpSState" class="select2-theme browser-default"  runat="server"  ClientIDMode="Static" TabIndex="38" AutoPostBack="true" OnSelectedIndexChanged="drpSState_SelectedIndexChanged" />
                                                    <label class="active" for="drpSState">State</label>
                                                 </div>
                                                <div class="input-field col m3">
                                                    <asp:DropDownList ID="drpSCity" class="select2-theme browser-default" runat="server"  ClientIDMode="Static" AutoPostBack="true" TabIndex="39" OnSelectedIndexChanged="drpSCity_SelectedIndexChanged" />
                                                    <label class="active" for="drpSCity">City </label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                
                                                <div class="input-field col m4">
                                                    <asp:TextBox ID="txtSPincode" runat="server" TabIndex="40" class="form-control"  ClientIDMode="Static" Placeholder="" MaxLength="10"/>
                                                    <label class="active" for="txtSPincode">Pincode</label>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="pnl_Production" class="col m12 mt-1" runat="server" clientidmode="Static" enableviewstate="true" style="display: none;">                                            
                                           <div class="row">
                                                <div class="input-field col m3">
                                                    <label class="active" for="txtHKMoter">H.K. MOTOR MAKE</label>
                                                    <asp:TextBox ID="txtHKMoter" runat="server" class="form-control" ClientIDMode="Static" TabIndex="80" placeholder="" />
                                                </div>
                                                <div class="input-field col m3">
                                                    <label class="active" for="txtHKMoterSR">Sr.No.</label>
                                                    <asp:TextBox ID="txtHKMoterSR" runat="server" class="form-control" ClientIDMode="Static" TabIndex="80" placeholder="" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="input-field col m3">
                                                    <label class="active" for="txtPreCarrRecPlace">C.T. MOTOR MAKE</label>
                                                    <asp:TextBox ID="txtCTMotor" runat="server" class="form-control" ClientIDMode="Static" TabIndex="81" placeholder="" />
                                                </div>
                                                <div class="input-field col m3">
                                                    <label class="active" for="txtCTMotorSR">Sr.No.</label>
                                                    <asp:TextBox ID="txtCTMotorSR" runat="server" class="form-control" ClientIDMode="Static" TabIndex="80" placeholder="" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="input-field col m3">
                                                    <label class="active" for="txtHTBreak">H.T. BREAK MAKE</label>
                                                    <asp:TextBox ID="txtHTBreak" runat="server" class="form-control" ClientIDMode="Static" TabIndex="82" placeholder="" />
                                                </div>
                                                <div class="input-field col m3">
                                                    <label class="active" for="txtHTBreakSR">Sr.No.</label>
                                                    <asp:TextBox ID="txtHTBreakSR" runat="server" class="form-control" ClientIDMode="Static" TabIndex="80" placeholder="" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="input-field col m3">
                                                    <label class="active" for="txtCTBreak">C.T. BREAK MAKE</label>
                                                    <asp:TextBox ID="txtCTBreak" runat="server" class="form-control" ClientIDMode="Static" TabIndex="82" placeholder="" />
                                                </div>
                                                <div class="input-field col m3">
                                                    <label class="active" for="txtCTBreakSR">Sr.No.</label>
                                                    <asp:TextBox ID="txtCTBreakSR" runat="server" class="form-control" ClientIDMode="Static" TabIndex="80" placeholder="" />
                                                </div>
                                            </div>                                            
                                        </div>

                                        <div id="pnl_Attachment" class="col m12 mt-1" runat="server" clientidmode="Static" enableviewstate="true" style="display: none;" tabindex="">
                                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                    <uc1:myModuleAttachment runat="server" id="myModuleAttachment" />
                                            </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </div>
                                    </div>
                                </div>
                                <div class="row padding-1 gradient-45deg-blue-grey-blue-grey vertical-align-bottom" style="margin-top: 10px;">
                                    <div class="col m12">
                                        <button type="button" id="btnReset" runat="server" clientidmode="Static" class="btn orange left" onserverclick="btnReset_Click" tabindex="60"><i class="material-icons left">backspace</i>Clear & Add New</button>
                                        <button type="button" id="btnSaveproforma" runat="server" clientidmode="Static" class="btn cyan  right mr-1" onserverclick="btnSaveproforma_Click" tabindex="58"><i class="material-icons left">email</i>Save - Send Proforma</button>
                                        <button type="button" id="btnSaveEmail" runat="server" clientidmode="Static" class="btn cyan  right mr-1" onserverclick="btnSaveEmail_Click" tabindex="58"><i class="material-icons left">email</i>Save - Send Email</button>
                                        <button type="button" id="btnSave" runat="server" clientidmode="Static" class="btn cyan right mr-1" onserverclick="btnSave_Click" tabindex="59"><i class="material-icons left">save</i>Save</button>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                    <%-- PopUp Modal Box to Open Window --%>
                    <asp:Button ID="Button1" CssClass="hide" runat="server" Text="Fill Form in Popup" />
                    <cc1:ModalPopupExtender ID="myModalPopup" BehaviorID="mpe" runat="server" ClientIDMode="Static" PopupControlID="Panl1" TargetControlID="Button1" CancelControlID="Button2" BackgroundCssClass="Background">
                    </cc1:ModalPopupExtender>
                    <asp:Panel ID="Panl1" runat="server" CssClass="Popup" align="center" Style="display: none; border-radius: 10px; padding-right: 10px !important;">
                        <div id="myModal123">
                            <div class="modal-header position-sticky gradient-45deg-light-blue-indigo m-0" style="margin-bottom: 10px !important;">
                                <h5 class=" z-depth-5" style="font-size: 2rem !important; font-weight: 800; line-height: 50px; margin: 0; text-align: left; padding-left: 15px;">
                                    <i class="material-icons prefix">ac_unit</i>
                                    <span id="spnModuleHeader" runat="server" clientidmode="static">Manage Module</span>
                                    <asp:Button CssClass="btnTopRightCorner float-right" ID="Button2" runat="server" Text="" />
                                </h5>
                            </div>
                        </div>
                        <iframe id="ifrModule" src="about:blank" runat="server" clientidmode="static" scrolling="auto" style="border: 1px solid silver; background-color: transparent; width: 100%; height: 90%; padding: 5px;"></iframe>
                        <br />
                    </asp:Panel>

                    <script type="text/javascript">
                        $("input").keypress(function (event) {
                            if (event.which == 13) {
                                event.preventDefault();
                                //$("form").submit();
                            }
                        });

                        function bindDDLTo(selector) {
                            if ($(selector).val().length >= 1) {
                                jQuery.ajax({
                                    type: "POST",
                                    url: "InquiryInfo.aspx/FilterCustomerByModule",
                                    data: '{pCustName:\'' + $(selector).val() + '\', pSearchModule:\'CustomerSearchAll\'}',
                                    contentType: "application/json; charset=utf-8",
                                    success: function (data) {
                                        console.log(data);
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
                                                //search = search.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&');
                                                //var re = new RegExp("(" + search.split(' ').join('|') + ")", "gi");
                                                return '<div class="autocomplete-suggestion" data-langname="' + item.CustomerID + '" data-lang="' + item.CustomerName + '" data-val="' + search + '">' + item.CustomerName + '</div>';
                                            },
                                            onSelect: function (e, term, item) {
                                                //console.log('Item "' + item.data('langname') + ' (' + item.data('lang') + ')" selected by ' + (e.type == 'keydown' ? 'pressing enter or tab' : 'mouse click') + '.');
                                                $(selector).val(item.html());
                                                $("#hdnCustomerID").val(item.data('langname'));
                                                $("#txtReference").focus();
                                            }
                                        });
                                    },
                                    error: function (r) { alert('Error : ' + r.responseText); },
                                    failure: function (r) { alert('failure'); }
                                });
                            }
                            else {
                                if ($(selector).val().length == 0) {
                                    $("#hdnCustomerID").val('');
                                }
                            }
                        }

                        function bindDDLProductTo(selector) {
                            var X = $("#hdnCustWisePro").val();
                            var Y = 0;
                            if (X.toLowerCase() == 'yes' && $("#hdnCustomerID").val() != '')
                                Y = $("#hdnCustomerID").val();
                            if ($(selector).val().length >= 1) {
                                jQuery.ajax({
                                    type: "POST",
                                    url: "InquiryInfo.aspx/FilterProductCust",
                                    data: '{pProductName:\'' + $(selector).val() + '\', pSearchModule:\'ProductSearchTypeQuotation\', CustomerID:' + Y + '}',
                                    //data: '{pProductName:\'' + $(selector).val() + '\', pSearchModule:\'ProductSearchTypeSalesOrder\'}',
                                    contentType: "application/json; charset=utf-8",
                                    success: function (data) {
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
                                                return '<div class="autocomplete-suggestion" data-langname="' + item.pkID + '" data-lang="' + item.ProductNameLong + '" data-val="' + search + '">' + item.ProductNameLong + '</div>';
                                            },
                                            onSelect: function (e, term, item) {
                                                //console.log('Item "' + item.data('langname') + ' (' + item.data('lang') + ')" selected by ' + (e.type == 'keydown' ? 'pressing enter or tab' : 'mouse click') + '.');
                                                $(selector).val(item.data('lang'));
                                                $("#hdnProductID").val(item.data('langname'));
                                                $("#txtUnit").focus();
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
                                    $("#hdnProductID").val('');
                                }
                            }
                        }
                        function clearProductField() {
                            $("#hdnProductID").val('');
                            $("#txtProductName").val('');
                            $("#txtQuantity").val('');
                            $("#txtUnit").val('');
                            $("#txtUnitRate").val('');
                            $("#txtDiscountPercent").val('');
                            $("#txtNetRate").val('');
                            $("#txtAmount").val('');
                            $("#txtTaxRate").val('');
                            $("#txtTaxAmount").val('');
                            $("#txtNetAmount").val('');
                            $("#txtProductName").focus();
                        }
                        $('#btnReset').focusout(function () {
                            $('#txtOrderNo').focus();
                        });

                    </script>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>mm
