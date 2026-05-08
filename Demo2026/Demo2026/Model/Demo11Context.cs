using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace Demo2026.Model;

public partial class Demo11Context : DbContext
{
    public Demo11Context()
    {
    }

    public Demo11Context(DbContextOptions<Demo11Context> options)
        : base(options)
    {
    }

    public virtual DbSet<Agent> Agents { get; set; }
    public virtual DbSet<AgentType> AgentTypes { get; set; }
    public virtual DbSet<User> Users { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseSqlServer("Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=Popryzhenok;Integrated Security=True;Encrypt=False");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Agent>(entity =>
        {
            entity.ToTable("Agent");
            entity.HasKey(e => e.Id).HasName("PK_Agent");
            entity.Property(e => e.Id).ValueGeneratedOnAdd();
            entity.Property(e => e.Title).HasMaxLength(150);
            entity.Property(e => e.Address).HasMaxLength(300);
            entity.Property(e => e.Inn).HasMaxLength(12).IsUnicode(false).HasColumnName("INN");
            entity.Property(e => e.Kpp).HasMaxLength(9).IsUnicode(false).HasColumnName("KPP");
            entity.Property(e => e.DirectorName).HasMaxLength(100);
            entity.Property(e => e.Phone).HasMaxLength(20);
            entity.Property(e => e.Email).HasMaxLength(255);
            entity.Property(e => e.Logo).HasMaxLength(100);

            entity.HasOne(d => d.AgentType).WithMany(p => p.Agents)
                .HasForeignKey(d => d.AgentTypeId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Agent_AgentType");
        });

        modelBuilder.Entity<AgentType>(entity =>
        {
            entity.ToTable("AgentType");
            entity.HasKey(e => e.Id).HasName("PK_AgentType");
            entity.Property(e => e.Id).ValueGeneratedOnAdd();
            entity.Property(e => e.Title).HasMaxLength(50);
            entity.Property(e => e.Image).HasMaxLength(100);
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.ToTable("User");
            entity.HasKey(e => e.Login).HasName("PK_User");
            entity.Property(e => e.Login).HasMaxLength(50);
            entity.Property(e => e.Password).HasMaxLength(50);
            entity.Property(e => e.Role).HasMaxLength(50);
            entity.Property(e => e.FirstName).HasMaxLength(50);
            entity.Property(e => e.MiddleName).HasMaxLength(50);
            entity.Property(e => e.LastName).HasMaxLength(50);
        });
    }
}
