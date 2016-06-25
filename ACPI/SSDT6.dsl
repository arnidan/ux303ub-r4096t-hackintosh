/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20160422-64(RM)
 * Copyright (c) 2000 - 2016 Intel Corporation
 * 
 * Disassembling to non-symbolic legacy ASL operators
 *
 * Disassembly of SSDT6, Mon Jun  6 12:44:13 2016
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x000007AE (1966)
 *     Revision         0x02
 *     Checksum         0x4C
 *     OEM ID           "SgRef"
 *     OEM Table ID     "SgPch"
 *     OEM Revision     0x00001000 (4096)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20120913 (538052883)
 */
DefinitionBlock ("", "SSDT", 2, "SgRef", "SgPch", 0x00001000)
{
    External (_SB_.GGOV, MethodObj)    // 1 Arguments
    External (_SB_.PCI0.LPCB.EC0_.RRAM, MethodObj)    // 1 Arguments
    External (_SB_.PCI0.LPCB.EC0_.WRAM, MethodObj)    // 2 Arguments
    External (_SB_.PCI0.RP01, DeviceObj)
    External (_SB_.PCI0.RP01._ADR, IntObj)
    External (_SB_.PCI0.RP01.PEGP.GC6I, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.RP01.PEGP.GC6O, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.RP01.PEGP.NHDA, FieldUnitObj)
    External (_SB_.SGOV, MethodObj)    // 2 Arguments
    External (DLHR, FieldUnitObj)
    External (DLPW, FieldUnitObj)
    External (EBAS, FieldUnitObj)
    External (EECP, FieldUnitObj)
    External (GPRW, MethodObj)    // 2 Arguments
    External (HRA0, FieldUnitObj)
    External (HRE0, FieldUnitObj)
    External (HRG0, FieldUnitObj)
    External (HYSS, FieldUnitObj)
    External (OSYS, FieldUnitObj)
    External (PWA0, FieldUnitObj)
    External (PWE0, FieldUnitObj)
    External (PWG0, FieldUnitObj)
    External (RPA1, FieldUnitObj)
    External (SGGP, FieldUnitObj)
    External (SGMD, FieldUnitObj)
    External (XBAS, FieldUnitObj)

    Scope (\_SB.PCI0.RP01)
    {
        OperationRegion (MSID, SystemMemory, EBAS, 0x50)
        Field (MSID, DWordAcc, Lock, Preserve)
        {
            VEID,   16, 
            Offset (0x40), 
            NVID,   32, 
            Offset (0x4C), 
            ATID,   32
        }

        OperationRegion (RPCX, SystemMemory, Add (Add (\XBAS, ShiftLeft (ShiftRight (And (\_SB.PCI0.RP01._ADR, 0x00FF0000), 0x10), 0x0F)), ShiftLeft (And (\RPA1, 0x0F), 0x0C)), 0x1000)
        Field (RPCX, DWordAcc, NoLock, Preserve)
        {
            PVID,   16, 
            PDID,   16, 
            CMDR,   8, 
            Offset (0x19), 
            PRBN,   8, 
            Offset (0x4A), 
            CEDR,   1, 
            Offset (0x50), 
            ASPM,   2, 
                ,   2, 
            LNKD,   1, 
            Offset (0x69), 
                ,   2, 
            LREN,   1, 
            Offset (0xA4), 
            D0ST,   2, 
            Offset (0x328), 
                ,   19, 
            LNKS,   4
        }

        Name (TDGC, Zero)
        Name (DGCX, Zero)
        Name (TGPC, Buffer (0x04)
        {
             0x00                                           
        })
        PowerResource (PC09, 0x00, 0x0000)
        {
            Name (_STA, One)  // _STA: Status
            Method (_ON, 0, Serialized)  // _ON_: Power On
            {
                If (LEqual (TDGC, One))
                {
                    If (LEqual (DGCX, 0x03))
                    {
                        Store (One, _STA)
                        \_SB.PCI0.RP01.PEGP.GC6O ()
                    }
                    ElseIf (LEqual (DGCX, 0x04))
                    {
                        Store (One, _STA)
                        \_SB.PCI0.RP01.PEGP.GC6O ()
                    }

                    Store (Zero, TDGC)
                    Store (Zero, DGCX)
                }
                ElseIf (LNotEqual (OSYS, 0x07D9))
                {
                    \_SB.PCI0.RP01.PEGP.HGON ()
                    Or (CMDR, 0x07, CMDR)
                    Store (Zero, D0ST)
                    Store (Zero, \_SB.PCI0.RP01.PEGP.NHDA)
                    If (LEqual (VEID, 0x10DE))
                    {
                        Store (HYSS, NVID)
                    }

                    If (LEqual (VEID, 0x1002))
                    {
                        Store (HYSS, ATID)
                    }

                    Store (One, _STA)
                }
            }

            Method (_OFF, 0, Serialized)  // _OFF: Power Off
            {
                If (LEqual (TDGC, One))
                {
                    CreateField (TGPC, Zero, 0x03, GUPC)
                    If (LEqual (ToInteger (GUPC), One))
                    {
                        \_SB.PCI0.RP01.PEGP.GC6I ()
                        Store (Zero, _STA)
                    }
                    ElseIf (LEqual (ToInteger (GUPC), 0x02))
                    {
                        \_SB.PCI0.RP01.PEGP.GC6I ()
                        Store (Zero, _STA)
                    }
                }
                ElseIf (LNotEqual (OSYS, 0x07D9))
                {
                    \_SB.PCI0.RP01.PEGP.HGOF ()
                    Store (Zero, _STA)
                }
            }
        }

        Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
        {
            PC09
        })
        Name (_PR2, Package (0x01)  // _PR2: Power Resources for D2
        {
            PC09
        })
        Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
        {
            PC09
        })
        Method (_S0W, 0, NotSerialized)  // _S0W: S0 Device Wake State
        {
            Return (0x04)
        }

        Device (PEGP)
        {
            Name (_ADR, Zero)  // _ADR: Address
            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
            {
                Return (GPRW (0x69, 0x04))
            }
        }

        Device (PEGA)
        {
            Name (_ADR, One)  // _ADR: Address
            OperationRegion (ACAP, PCI_Config, \EECP, 0x14)
            Field (ACAP, DWordAcc, NoLock, Preserve)
            {
                Offset (0x10), 
                LCT1,   16
            }

            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
            {
                Return (GPRW (0x69, 0x04))
            }
        }
    }

    Scope (\_SB.PCI0.RP01.PEGP)
    {
        Name (IVID, 0xFFFF)
        Name (ELCT, Zero)
        Name (HVID, Zero)
        Name (HDID, Zero)
        Name (TCNT, Zero)
        Name (LDLY, 0x64)
        Name (LTRE, Zero)
        OperationRegion (PCIS, SystemMemory, Add (\XBAS, ShiftLeft (PRBN, 0x14)), 0xF0)
        Field (PCIS, AnyAcc, Lock, Preserve)
        {
            DVID,   16, 
            Offset (0x0B), 
            CBCC,   8, 
            Offset (0x2C), 
            SVID,   16, 
            SDID,   16
        }

        OperationRegion (PCAP, SystemMemory, Add (Add (\XBAS, ShiftLeft (PRBN, 0x14)), \EECP), 0x14)
        Field (PCAP, DWordAcc, NoLock, Preserve)
        {
            Offset (0x10), 
            LCTL,   16
        }

        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            Store (Zero, \_SB.PCI0.RP01.PEGP._ADR)
        }

        Method (HGON, 0, Serialized)
        {
            If (LNotEqual (SGGP, One))
            {
                Return (Zero)
            }

            If (LEqual (CCHK (One), Zero))
            {
                Return (Zero)
            }

            SGPO (HRE0, HRG0, HRA0, One)
            SGPO (PWE0, PWG0, PWA0, One)
            Sleep (DLPW)
            SGPO (HRE0, HRG0, HRA0, Zero)
            Sleep (DLHR)
            Store (Zero, LNKD)
            While (LLess (LNKS, 0x07))
            {
                Sleep (One)
            }

            Store (\_SB.PCI0.RP01.PEGP.LTRE, \_SB.PCI0.RP01.LREN)
            Store (One, \_SB.PCI0.RP01.CEDR)
            Store (HVID, SVID)
            Store (HDID, SDID)
            Or (And (ELCT, 0x43), And (LCTL, 0xFFBC), LCTL)
            Or (And (ELCT, 0x43), And (\_SB.PCI0.RP01.PEGA.LCT1, 0xFFBC), \_SB.PCI0.RP01.PEGA.LCT1)
            \_SB.PCI0.LPCB.EC0.WRAM (0x052B, 0x9E)
            \_SB.PCI0.LPCB.EC0.WRAM (0x0520, 0x97)
            Store (\_SB.PCI0.LPCB.EC0.RRAM (0x0521), Local0)
            And (Local0, 0xCF, Local0)
            Or (Local0, 0x20, Local0)
            \_SB.PCI0.LPCB.EC0.WRAM (0x0521, Local0)
            Return (Zero)
        }

        Method (HGOF, 0, Serialized)
        {
            If (LNotEqual (SGGP, One))
            {
                Return (Zero)
            }

            If (LEqual (CCHK (Zero), Zero))
            {
                Return (Zero)
            }

            Store (\_SB.PCI0.LPCB.EC0.RRAM (0x0521), Local0)
            And (Local0, 0xCF, Local0)
            \_SB.PCI0.LPCB.EC0.WRAM (0x0521, Local0)
            \_SB.PCI0.LPCB.EC0.WRAM (0x0520, 0x95)
            \_SB.PCI0.LPCB.EC0.WRAM (0x03A4, Zero)
            \_SB.PCI0.LPCB.EC0.WRAM (0x03A5, Zero)
            Store (LCTL, ELCT)
            Store (SVID, HVID)
            Store (SDID, HDID)
            Store (\_SB.PCI0.RP01.LREN, \_SB.PCI0.RP01.PEGP.LTRE)
            Store (One, LNKD)
            While (LNotEqual (LNKS, Zero))
            {
                Sleep (One)
            }

            SGPO (HRE0, HRG0, HRA0, One)
            SGPO (PWE0, PWG0, PWA0, Zero)
            Return (Zero)
        }

        Method (SGST, 0, Serialized)
        {
            If (And (SGMD, 0x0F))
            {
                If (LNotEqual (SGGP, One))
                {
                    Return (0x0F)
                }

                If (LNotEqual (DVID, 0xFFFF))
                {
                    If (LEqual (CBCC, 0x03))
                    {
                        Return (0x0F)
                    }
                }

                Return (Zero)
            }

            If (LNotEqual (DVID, 0xFFFF))
            {
                Return (0x0F)
            }

            Return (Zero)
        }

        Method (SGPO, 4, Serialized)
        {
            If (LEqual (Arg2, Zero))
            {
                Not (Arg3, Arg3)
                And (Arg3, One, Arg3)
            }

            If (LEqual (SGGP, One))
            {
                If (CondRefOf (\_SB.SGOV))
                {
                    \_SB.SGOV (Arg1, Arg3)
                }
            }
        }

        Method (SGPI, 4, Serialized)
        {
            If (LEqual (Arg0, One))
            {
                If (CondRefOf (\_SB.GGOV))
                {
                    Store (\_SB.GGOV (Arg2), Local0)
                }
            }

            If (LEqual (Arg3, Zero))
            {
                Not (Local0, Local0)
                And (Local0, One, Local0)
            }

            Return (Local0)
        }

        Method (CCHK, 1, NotSerialized)
        {
            If (LEqual (PVID, IVID))
            {
                Return (Zero)
            }

            If (LEqual (Arg0, Zero))
            {
                If (LEqual (SGPI (SGGP, PWE0, PWG0, PWA0), Zero))
                {
                    Return (Zero)
                }
            }
            ElseIf (LEqual (Arg0, One))
            {
                If (LEqual (SGPI (SGGP, PWE0, PWG0, PWA0), One))
                {
                    Return (Zero)
                }
            }

            Return (One)
        }
    }
}

