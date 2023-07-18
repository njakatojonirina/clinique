<nav class="sidebar sidebar-offcanvas" id="sidebar">
    <div class="sidebar-brand-wrapper d-none d-lg-flex align-items-center justify-content-center fixed-top">
        <a class="sidebar-brand brand-logo" href="index.html"><img src="<%=request.getContextPath()%>/assets/images/logo.svg" alt="logo" /></a>
        <a class="sidebar-brand brand-logo-mini" href="index.html"><img src="<%=request.getContextPath()%>/assets/images/logo-mini.svg" alt="logo" /></a>
    </div>
    <ul class="nav">
        <li class="nav-item menu-items" >
            <a class="nav-link" href="#">
                <span class="menu-icon">
                    <i class="mdi mdi-speedometer"></i>
                </span>
              <span class="menu-title">DashBoard</span>
            </a>
        </li>
        <li class="nav-item menu-items">
            <a class="nav-link" href="<%=request.getContextPath()%>/listerGeneraliser?modele=Patient" >
                <span class="menu-icon">
                    <i class="mdi mdi-account-outline"></i>
                </span>
                <span class="menu-title">Patient</span>
            </a>
        </li>
        <li class="nav-item menu-items">
            <a class="nav-link" href="<%=request.getContextPath()%>/listerGeneraliser?modele=Acte" >
                <span class="menu-icon">
                    <i class="mdi mdi-hospital"></i>
                </span>
                <span class="menu-title">Acte</span>
            </a>
        </li>
        <li class="nav-item menu-items">
            <a class="nav-link" href="<%=request.getContextPath()%>/listerGeneraliser?modele=Depense" >
                <span class="menu-icon">
                    <i class="mdi mdi-coin"></i>
                </span>
                <span class="menu-title">Depense</span>
            </a>
        </li>
        <li class="nav-item menu-items">
            <a class="nav-link" href="<%=request.getContextPath()%>/deconection" >
                <span class="menu-icon">
                    <i class="mdi mdi-exit-to-app"></i>
                </span>
                <span class="menu-title">Deconection</span>
            </a>
        </li>
    </ul>
</nav>