<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="myMaterialStatus.ascx.cs" Inherits="StarsProject.myMaterialStatus" %>

<asp:HiddenField ID="hdnView" runat="server" ClientIDMode="Static" EnableViewState="true" />
<asp:HiddenField ID="hdnViewType" runat="server" ClientIDMode="Static" EnableViewState="true" />
<asp:HiddenField ID="hdnMonth" runat="server" ClientIDMode="Static" EnableViewState="true" />
<asp:HiddenField ID="hdnYear" runat="server" ClientIDMode="Static" EnableViewState="true" />
<asp:HiddenField ID="hdnStatus" runat="server" ClientIDMode="Static" EnableViewState="true" />

<style type="text/css">
    #tblMaterialStatus tr td{ font-size:12px; color:black; }
</style>

<table id="tblMaterialStatus" class="stdtable" cellpadding="0" cellspacing="0" border="0" width="100%">
<asp:Repeater ID="rptMaterialStatus" runat="server" OnItemDataBound="rptMaterialStatus_ItemDataBound">
    <HeaderTemplate>
        <thead>
            <tr>
                <% if (hdnView.Value == "purchase") { %>
                    <th id="headOrd1" runat="server" class="left-align">Order #</th>
                <% } 
                else { %>
                    <th id="headOrd2" runat="server" class="left-align">Order #</th>
                <% } %>
                <th class="left-align" style="width:250px;">Product Name</th>
                <th class="center-align">Order Qty</th>
                <th id="headINOUT" runat="server" class="center-align">Dispatch Qty</th>
                <th class="center-align">Pending Qty</th>
                <% if (hdnViewType.Value.ToLower() == "detail") { %>
                <th class="center-align">Approval</th>
                <% } %>
                <th class="center-align">Status</th>
            </tr>
        </thead>
    </HeaderTemplate>
    <ItemTemplate>
        <tr class="blueShed">
            <asp:HiddenField ID="hdnApprovalStatus" runat="server" ClientIDMode="Static" EnableViewState="true" Value='<%# Eval("ApprovalStatus") %>' />
            <asp:HiddenField ID="hdnRequestStatus" runat="server" ClientIDMode="Static" EnableViewState="true" Value='<%# Eval("RequestStatus") %>' />
            <asp:HiddenField ID="hdnDeliveryStatus" runat="server" ClientIDMode="Static" EnableViewState="true" Value='<%# Eval("DeliveryStatus") %>' />

            <% if (hdnView.Value == "purchase") { %>
                <td id="itemOrd1" runat="server" class="left-align">
                    <a id="lnkSearch1" data-position="center" href="javascript:showOrderForm('purchase' ,'<%# Eval("pkID") %>');"><%# Eval("OrderNo") %></a>
                </td>
            <% } 
            else { %>
                <td id="itemOrd2" runat="server" class="left-align">
                    <a id="lnkSearch2" data-position="center" href="javascript:showOrderForm('sale' ,'<%# Eval("pkID") %>');"><%# Eval("OrderNo") %></a>
                </td>
            <% } %>

            <% if (hdnViewType.Value.ToLower() == "detail") { %>
                <td class="left-align" style="width:250px;"><b class="blue-text"><%# Eval("CustomerName") %></b><br /><%# Eval("ProductNameLong") %></td>
            <% } 
            else { %>
                <td class="left-align" style="width:250px;"><%# Eval("ProductNameLong") %></td>
            <% } %>
            <td class="center-align"><%# Eval("OrderQty") %></td>
            <td class="center-align"><%# Eval("DispatchQty") %></td>
            <td class="center-align"><%# Eval("PendingQty") %></td>   
            <% if (hdnViewType.Value.ToLower() == "detail") { %>
            <td id="tdApproval" runat="server" class="center-align">
                <i class="material-icons" style="font-size: 20px; padding: 5px;">add</i>
            </td>   
            <% } %>      
            <td class="center-align">
                <asp:Label ID="tdStatus" runat="server" style="padding: 4px 4px 4px 8px !important;border-radius: 5px;"><%# Eval("RequestStatus") %></asp:Label>
            </td>
        </tr>
    </ItemTemplate>
</asp:Repeater>
</table>
