class LinksController < ApplicationController
    def new
      @link = current_user.links.build
    end

    # POST /links
    def create
        @link = @link = current_user.links.build(link_params)
    
        # Añado valores por defecto
        @link.access_count = 0
        @link.slug = generate_unique_slug(@link.url)
    
        if @link.type == 'Efimero'
          @link.accessed = false
        end
    
        respond_to do |format|
          if @link.save
            format.html { redirect_to links_url, notice: "Link was successfully created." }
            format.json { render :show, status: :created, location: @link }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @link.errors, status: :unprocessable_entity }
          end
        end
    end

    # GET /links
    def index
        if current_user
            @own_links = Link.where(user_id: current_user.id)
            @others_links = Link.where.not(user_id: current_user.id)
        else 
            @others_links = Link.all
            @own_links = []
        end
        @links = {
            own_links: @own_links,
            others_links: @others_links
        }
        @links
    end

    def redirect_to_link
        @link = Link.find(params[:id])
    
        case @link.type
        when 'Regular'
            @link.access_count += 1
            @link.save
            @access = new Access(link: @link, ip_address: request.remote_ip)
            @access.save
            redirect_to @link.url, allow_other_host: true
        when 'Temporal'
            redirect_to_temporal_link
        when 'Efimero'
            redirect_to_efimero_link
        when 'Privado'
            redirect_to_privado_link
        end
    end

    # GET /links/:id/edit
    def edit
        @link = Link.find(params[:id])
    end

    # PATCH /links/:id
    def update
        @link = Link.find(params[:id])

        if @link.update(link_params)
            redirect_to links_url, notice: 'El link ha sido actualizado.'
        else
            render :edit
        end
    end

    # DELETE /links/:id
    def custom_delete
        @link = Link.find(params[:id])
        @link.destroy
        redirect_to links_url, notice: 'El link ha sido eliminado exitosamente.'
    end

    # GET /links/:id/stats
    def stats
        @link = Link.find(params[:id])

        # Obtener detalles de accesos
        @access_details = Access.where(link: @link).order(created_at: :desc)

        # Obtener la cantidad de accesos por día
        @access_count_by_day = Access.where(link: @link).group(Arel.sql('DATE(created_at)')).count
        
        respond_to do |format|
            format.html
        end
    end

    def check_password_link
        @link = Link.find(params[:id])
        entered_password = params[:password]
    
        if entered_password == @link.password
            # Contraseña correcta, redirigir a la URL original del link
            @link.access_count += 1
            @link.save
            @access = Access.create(link: @link, ip_address: request.remote_ip)
            @access.save
            redirect_to @link.url, allow_other_host: true
        else
            # Contraseña incorrecta, mostrar mensaje de error y redirigir a la lista de links
            flash.now[:alert] = 'Contraseña incorrecta. Inténtelo de nuevo.'
            render links_url, allow_other_host: true
        end
    end
    
    private

    def link_params
        # Parámetros permitidos para la creación del link
        params.require(:link).permit(:name, :url, :type, :expiration_date, :password, :accessed)
    end

    def generate_unique_slug(base_string)
        allowed_characters = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a + ['-', '_']
      
        random_string = ''
      
        loop do
            random_string += allowed_characters.sample until random_string.length >= 8
            break unless Link.exists?(slug: random_string)
            random_string = ''  # Restablecer el string si ya existe en la base de datos
        end
      
        random_string
    end

    def redirect_to_temporal_link
        if @link.expiration_date < DateTime.now
            # El enlace temporal expiró
            flash[:alert] = 'El link temporal seleccionado ya ha expirado, por lo que ya no es válido.'
            redirect_to links_url
        else
            # El enlace temporal es válido, contabiliza el acceso y realiza la redirección
            @link.access_count += 1
            @link.save
            @access = new Access(link: @link, ip_address: request.remote_ip)
            @access.save
            redirect_to @link.url, allow_other_host: true
        end
    end

    def redirect_to_efimero_link
        if @link.accessed
            # El enlace efimero ya fue accedido
            flash[:alert] = 'El link efímero seleccionado ya ha sido accedido, por lo que ya no es válido.'
            redirect_to links_url, target: '_this'
        else
            # El enlace efímero es válido, contabiliza el acceso y realiza la redirección
            @link.access_count += 1
            @link.accessed = true
            @link.save
            @access = new Access(link: @link, ip_address: request.remote_ip)
            @access.save
            redirect_to @link.url, allow_other_host: true
        end
    end

    def redirect_to_privado_link
        @link = Link.find(params[:id])
        render 'links/redirect_to_privado_link'
    end
end